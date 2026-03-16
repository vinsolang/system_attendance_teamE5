import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F8), // Light grayish background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: const Text("Back", style: TextStyle(color: Colors.black)),
        ),
        title: const Text(
          "My Attendance",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // --- MAIN ATTENDANCE CARD ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF5EBF5), // Light lavender/pinkish color
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "30 October 2025",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 20, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "Check-in:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 28, top: 8),
                    child: Text(
                      "Time: 7:45 AM",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 20, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "Check-out:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            // --- CHECK-OUT BUTTON ---
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Check-out",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      "5:15 PM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}