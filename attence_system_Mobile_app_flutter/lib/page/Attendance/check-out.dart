import 'package:flutter/material.dart';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors based on the image
    const Color cardBg = Color(0xFFF4EBF7);
    const Color scaffoldBg = Color(0xFFF9F7FA);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios, size: 18),
                    const Text("Back", style: TextStyle(fontSize: 16)),
                    const Spacer(),
                    const Text(
                      "My Attendance",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),

              // Current Date Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "30 October 2025",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Icons.check, size: 20),
                        SizedBox(width: 8),
                        Text("Check-in:", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 30), // Space for inner card height
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Action Section (Pill and Map)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          "Check-in",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "7:45 AM",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Open map",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Your location is not available!",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),

              const Spacer(),

              // Attendance History Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Attendance",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See More", style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),

              // History Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "29 October 2025",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeColumn("Check-in:", "7:48 AM"),
                        _buildTimeColumn("Check-out:", "5:10 PM"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ],
    );
  }
}