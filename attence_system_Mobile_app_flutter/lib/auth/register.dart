// RegisterScreen.dart
import 'dart:convert';
import 'package:attence_system/auth/login.dart';
import 'package:attence_system/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // UPDATED: Single controller for Full Name
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String role = "EMPLOYEE"; // Match the enum/string in your backend

  Future<bool> registerUser() async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}/api/employees/login');
      
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": fullNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "role": role
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print("ERROR: $e");
      return false;
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // UI remains similar, but with fewer fields
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_1_outlined, size: 40),
                    SizedBox(width: 10),
                    Text("Register", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      buildInputField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        controller: fullNameController,
                      ),
                      const SizedBox(height: 15),
                      buildInputField(
                        label: "Email",
                        hint: "Enter email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      buildInputField(
                        label: "Password",
                        hint: "Enter password",
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool success = await registerUser();
                             if(success){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registered successfully")));
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration failed")));
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({required String label, required String hint, required TextEditingController controller, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}