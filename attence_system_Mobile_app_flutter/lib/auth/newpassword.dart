import 'package:flutter/material.dart';

class InputNewPasswordScreen extends StatelessWidget {
  const InputNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA), // Consistent background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // --- HEADER SECTION ---
              const Center(
                child: Text(
                  'Input New Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // --- INSTRUCTION CARD ---
              Center(
                child: Container(
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
                        'Check your Email and Input new password.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Placeholder for Input Field / Success Indicator
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0), // Soft grey pill
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // --- BOTTOM NAVIGATION ROW ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
                      label: const Text(
                        'Back',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // Next Button
                    TextButton(
                      onPressed: () {
                        // Navigate to Login or Success Screen
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
                        ],
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
}