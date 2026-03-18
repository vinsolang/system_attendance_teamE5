import 'dart:convert';
import 'package:attence_system/auth/forgotpassword.dart';
import 'package:attence_system/page/home.dart';
import 'package:attence_system/scanqr/scanqr.dart';
import 'package:attence_system/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// login.dart logic snippet
Future<bool> loginUser(String email, String password) async {
  try {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/employees/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', data['email'] ?? '');
      await prefs.setString('userRole', data['role'] ?? '');
      await prefs.setString('userId', data['employeeId']?.toString() ?? '');
      return true;

    } else {
      print("Login failed: ${response.body}");
      return false;
    }

  } catch (e) {
    print("Login error: $e");
    return false;
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA), // Match lavender background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              
              // --- HEADER SECTION ---
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.login_rounded, size: 40, color: Color(0xFF333333)),
                    SizedBox(width: 12),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- FORM CARD ---
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.03), // Light tray effect
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: 'Email',
                      hint: 'Enter email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    _buildInputField(
                      label: 'Password',
                      hint: 'Enter password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 25),
                    
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {

                          bool success = await loginUser(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if(success){

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login success")),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(userEmail: emailController.text.trim()),
                                
                              ),
                            );

                          }else{

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid email or password")),
                            );

                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333333),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Forgot Password Link
                    GestureDetector(
                      onTap: () { 
                        // Navigates to the Sign In page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                       },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(), // Pushes the bottom buttons to the end of the screen

              // --- BOTTOM NAVIGATION ROW ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
                      label: const Text(
                        'Back',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      onPressed: () { 
                        // Navigates to the Sign In page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScanQRScreen()),
                        );
                       },
                      child: const Text(
                        'Scan',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable input field widget
  Widget _buildInputField({required String label, required String hint,  required TextEditingController controller, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF4A4A4A)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFC0C0C0)),
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ],
    );
  }
}