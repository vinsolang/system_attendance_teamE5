import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF3F2F8);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER WITH BACK BUTTON ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_back_ios, size: 18),
                          Text(
                            "Back",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "About Us",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // --- CONTENT SECTION ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Attend log",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildBodyText(
                      "Welcome to Attend log, the best Human Resource Management digital platform that provides you an easier way to manage your Human Resource."
                    ),
                    const SizedBox(height: 20),
                    _buildBodyText(
                      "Currently, many organizations, companies, offices and some work places in Cambodia spend a lot of time completing tasks with complicated work operations. Our team committed to make your business operation better day to day with our cutting edge technology HR System. Attend log uses Beacon devices integrating with Mobile App to replace conventional fingerprint or card reading. With our touchless user interface, you can protect yourself and your employees from spreading Covid19."
                    ),
                    const SizedBox(height: 20),
                    _buildBodyText(
                      "Attend log has many useful features or modules like: Employee Management, Time & Attendance Management, Shift Management, Payroll Management and will go on to cover all complex work both back office and front office with Attend log."
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for consistent paragraph styling
  Widget _buildBodyText(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 15,
        height: 1.5,
        color: Colors.black87,
      ),
    );
  }
}