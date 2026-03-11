import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF3F2F8);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios, size: 18),
                        Text("Back", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Terms and condittions", // Matching your design's spelling
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60), 
                ],
              ),
            ),

            // --- TERMS CARD ---
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Terms and Conditions",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildTermsText(
                        "Attend log Services (Attend log) operated by BEONE PLATFORM CO., LTD. (“we”, “us” “our” or “the owner”), is a back office digital platform containing Website and App integrated with Beacon devices. Your use of Attend log or use of any of the services offered on or via Attend log is subject to these terms and conditions."
                      ),
                      const SizedBox(height: 15),
                      _buildTermsText(
                        "You should read these terms carefully before the use of Attend log. Browsing, access and use of Attend log means that the visitor agrees to these terms and conditions. The user becomes legally bound to these terms, guidelines and policies entirely at the time of browsing Attend log. Those who cannot follow these terms and conditions may not use Attend log."
                      ),
                      const SizedBox(height: 25),
                      _buildTermsText(
                        "As a first condition you must be 18 years or older, have the requisite power and authority to enter into these terms, truthfully and accurately provide all required information, including a legitimate email address, and obtain a unique username and password."
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Colors.black87,
      ),
    );
  }
}