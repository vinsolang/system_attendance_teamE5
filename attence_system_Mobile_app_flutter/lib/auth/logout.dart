import 'package:attence_system/auth/login.dart';
import 'package:attence_system/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  try {
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/api/employees/logout"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    print("Status: ${response.statusCode}");

  } catch (e) {
    print("Logout Error: $e");
  }

  // ✅ ALWAYS logout locally
  await prefs.clear();

  // ✅ REDIRECT to SignInScreen
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const SignInScreen()),
    (route) => false,
  );
}
class SignOutScreen extends StatelessWidget {
  const SignOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Soft color palette to match your existing design
    const Color bgColor = Color(0xFFF3F2F8);
    const Color buttonColor = Color(0xFFEEEAF0); // Soft grey-purple for buttons

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // --- HEADER ---
              const Center(
                child: Text(
                  'Are you Sure ?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),

              const Spacer(),

              // --- CONFIRMATION CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Do you want to sign out?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- YES BUTTON ---
                   _buildConfirmationButton(
                      label: 'Yes',
                      color: buttonColor,
                      onTap: () {
                        logout(context);
                      },
                    ),
                    const SizedBox(height: 15),

                    // --- CANCEL BUTTON ---
                    _buildConfirmationButton(
                      label: 'Cancel',
                      color: buttonColor,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the soft-styled confirmation buttons
  Widget _buildConfirmationButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}