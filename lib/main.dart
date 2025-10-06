import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arcanum/models/theme.dart';
import 'package:arcanum/controllers/auth_controller.dart';
import 'package:arcanum/controllers/product_controller.dart';
import 'package:arcanum/controllers/connectivity_controller.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(
          create: (_) => ProductController()..fetchProducts(),
        ),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const ArcanumApp(),
    ),
  );
}

/// Wrapper widget to listen to connectivity and show SnackBars
class ConnectivityListener extends StatefulWidget {
  final Widget child;
  const ConnectivityListener({required this.child, super.key});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  bool? _lastStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivity, _) {
        final isOnline = connectivity.isOnline;

        // Only show SnackBar if status is known (not null) and changed
        if (_lastStatus != isOnline) {
          _lastStatus = isOnline;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            final scaffoldMessenger = ScaffoldMessenger.of(context);
            scaffoldMessenger.clearSnackBars();

            final snackBar = SnackBar(
              content: Text(
                isOnline
                    ? "You are online\nNow you can browse all the features of Arcanum"
                    : "Nooo you are offline:(\nAt least you can still browse our products\nGo online to access all the features of Arcanum",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor:
                  isOnline ? Colors.green[700] : Colors.red[700],
              duration: isOnline
                  ? const Duration(seconds: 3)
                  : const Duration(seconds: 6), // longer for offline
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
            );

            scaffoldMessenger.showSnackBar(snackBar);
          });
        }

        return widget.child;
      },
    );
  }
}

class ArcanumApp extends StatelessWidget {
  const ArcanumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Arcanum',
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        fontFamily: GoogleFonts.aldrich().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(color: Colors.white),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.grey,
        fontFamily: GoogleFonts.aldrich().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(color: Colors.black),
      ),

      /// Wrap all pages in ConnectivityListener
      builder: (context, child) {
        return ConnectivityListener(child: child ?? const SizedBox());
      },

      home: const LoginScreen(),
    );
  }
}

