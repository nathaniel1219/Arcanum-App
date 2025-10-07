import 'package:flutter/material.dart';
import 'package:arcanum/controllers/auth_controller.dart';
import 'package:arcanum/screens/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth > 600;
            final double hPad = isWide ? 48.0 : 24.0;
            final double fieldW = isWide ? double.infinity : 280;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ARCANUM.png', height: 100),
                        const SizedBox(height: 40),

                        // Username
                        SizedBox(
                          width: fieldW,
                          child: TextFormField(
                            controller: usernameController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => (v == null || v.isEmpty) ? 'Please enter your username' : null,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Email
                        SizedBox(
                          width: fieldW,
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => (v == null || v.isEmpty) ? 'Please enter your email' : null,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        SizedBox(
                          width: fieldW,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => (v == null || v.isEmpty) ? 'Please enter a password' : null,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register Button
                        SizedBox(
                          width: fieldW,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isLoading = true);
                                      try {
                                        await AuthController().register(
                                          usernameController.text.trim(),
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          passwordController.text.trim(),
                                        );

                                        if (AuthController().isLoggedIn()) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text("Success"),
                                              content: const Text("User successfully registered."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(builder: (_) =>  HomeScreen()),
                                                    );
                                                  },
                                                  child: const Text(
                                                    "OK",
                                                    style: TextStyle(color: Color(0xFFFFBD59)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Registration Failed"),
                                            content: Text(e.toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          ),
                                        );
                                      } finally {
                                        setState(() => _isLoading = false);
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  )
                                : const Text('Register'),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? ", style: TextStyle(color: Colors.black)),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  "Login here",
                                  style: TextStyle(color: Color(0xFFFFBD59), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
