import 'package:flutter/material.dart';
import 'apply_for_leave.dart';
import 'my_request.dart';

class MyLeavePage extends StatelessWidget {
  const MyLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: const Text("Back", style: TextStyle(color: Colors.black)),
        ),
        title: const Text(
          "My Leave",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      //  FIX: Scrollable
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // TOP CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E6F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("15.5", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                            Text("Day Available"),
                          ],
                        ),

                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(value: 0.7),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildNavButton(
                      context,
                      Icons.calendar_today,
                      "Apply for Leave",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LeaveRequestScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    _buildNavButton(
                      context,
                      Icons.list,
                      "My Requests",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MyRequestPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E6F2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Upcoming Leave", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Nov 10 - Nov 12: Vacation"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(title),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}