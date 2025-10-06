import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arcanum/models/theme.dart';
import 'package:arcanum/controllers/auth_controller.dart';
import 'package:arcanum/controllers/product_controller.dart'; // ✅ Added ProductController import
import 'screens/auth/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(
          create: (_) => ProductController()..fetchProducts(),
        ), // ✅ Added ProductController to MultiProvider and fetchProducts() called here
      ],
      child: const ArcanumApp(),
    ),
  );
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
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.white,
        ),
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
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.black,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
