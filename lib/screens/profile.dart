import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../controllers/auth_controller.dart';
import 'auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isLoading = false;


  void _logout(BuildContext context) async {
    final auth = Provider.of<AuthController>(context, listen: false);
    await auth.logout();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (r) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final user = auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("No user logged in")));
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile Information",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 32),

                      ListTile(title: Text("Name: ${user.name}")),
                      ListTile(title: Text("Email: ${user.email}")),

                      const Divider(height: 32),

                      const Text(
                        "Theme",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Column(
                        children: [
                          ListTile(
                            title: const Text("System Default"),
                            leading: Radio<AppThemeMode>(
                              value: AppThemeMode.system,
                              groupValue: themeProvider.modeSetting,
                              onChanged: (AppThemeMode? value) {
                                if (value != null) themeProvider.setMode(value);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("Light Mode"),
                            leading: Radio<AppThemeMode>(
                              value: AppThemeMode.light,
                              groupValue: themeProvider.modeSetting,
                              onChanged: (AppThemeMode? value) {
                                if (value != null) themeProvider.setMode(value);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("Dark Mode"),
                            leading: Radio<AppThemeMode>(
                              value: AppThemeMode.dark,
                              groupValue: themeProvider.modeSetting,
                              onChanged: (AppThemeMode? value) {
                                if (value != null) themeProvider.setMode(value);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _logout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
    );
  }
}
