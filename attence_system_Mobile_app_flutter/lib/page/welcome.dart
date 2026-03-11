import 'package:attence_system/auth/login.dart';
import 'package:attence_system/auth/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: WelcomeScreen()));

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA), // Subtle lavender background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- LOGO SECTION ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 80, color: Color(0xFF333333)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('ATTENDANCE', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 1.2)),
                        Text('LOG', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 0.9)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // --- WELCOME TEXT ---
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose one to use Attendance',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 50),

                // --- BUTTON CARDS ---
                _buildActionCard(
                  context,
                  label: 'Sign In',
                  onTap: () {
                    // Navigates to the Sign In page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildActionCard(
                  context,
                  label: 'Register',
                  onTap: () {
                    // Navigates to the Register page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom widget to create the shadowed button inside the light card
  Widget _buildActionCard(BuildContext context, {required String label, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03), // Light purple/grey outer container
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}