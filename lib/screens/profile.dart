// lib/screens/profile.dart

import 'package:flutter/material.dart';
import 'package:arcanum/controller.dart';
import '../widgets/navbar.dart';
import '../models/user.dart';
import 'login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    Controller().logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false, // Remove all routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Controller().currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/ARCANUM.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
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
            const SizedBox(height: 20),

            Text("📧 Email: ${user.email}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Text("🔑 Password: ${user.password}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
    );
  }
}
