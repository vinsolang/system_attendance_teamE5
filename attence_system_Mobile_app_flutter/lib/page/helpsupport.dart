import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BACK BUTTON & TITLE ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 18),
                        Text("Back", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Help and Support",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60), // Balancing spacer
                ],
              ),
            ),

            // --- SEARCH SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("How Can We Help?", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- FAQ SECTIONS ---
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildFaqSection("Attendance Management", [
                    "How to check in/ out in mobile app?",
                  ]),
                  _buildFaqSection("Leave Management", [
                    "How to request leave in mobile app?",
                    "How to approve / reject employee request?",
                    "How employee request to cancel leave?",
                    "How supervisor/ admin approve/reject on request cancel lave?",
                  ]),
                  _buildFaqSection("Overtime Management", [
                    "How to request OT in mobile app?",
                    "How supervisor/ admin approve/ OT?",
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection(String title, List<String> questions) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(title, 
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        children: questions.map((q) => _buildQuestionItem(q)).toList(),
      ),
    );
  }

  Widget _buildQuestionItem(String question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
      ),
      child: Text(
        question,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}