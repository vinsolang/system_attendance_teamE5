import 'package:flutter/material.dart';

class MyLeavePage extends StatelessWidget {
  const MyLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6),
     appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // 1. Add this line to give the text room to breathe
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: const Text(
            "Back",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        title: const Text(
          "My Leave",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- TOP SUMMARY CARD ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1E6F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("15.5", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                          const Text("Day Available", style: TextStyle(fontSize: 16, color: Colors.black54)),
                          const SizedBox(height: 12),
                          const Text("Annual Leave: 10/10", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text("Sick Leave: 5.5/7", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Text("Replace: 7/7", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      // Right side Donut Chart
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 100, width: 100,
                              child: CircularProgressIndicator(
                                value: 0.75, // Adjust based on data
                                strokeWidth: 15,
                                backgroundColor: Colors.grey[300],
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  // --- NAVIGATION BUTTONS ---
                  _buildNavButton(Icons.calendar_today_outlined, "Apply for Leave"),
                  const SizedBox(height: 12),
                  _buildNavButton(Icons.groups_outlined, "My Requests"),
                  const SizedBox(height: 12),
                  _buildNavButton(Icons.event_note_outlined, "OverTime"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- UPCOMING LEAVE SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Your Leave", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text("See More", style: TextStyle(color: Colors.grey))),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1E6F2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Upcoming Leave", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text("Nov 10 - Nov 12: Vacation (3 days)", style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                      children: [
                        TextSpan(text: "Recent: "),
                        TextSpan(text: "Oct 25", style: TextStyle(color: Colors.blue)),
                        TextSpan(text: " Sick Leave - Approved"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D8E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}