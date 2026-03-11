import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

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
                        "Privacy & Security",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60), // Balance the back button
                ],
              ),
            ),

            // --- POLICY CONTAINER ---
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Privacy & Security Policy",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "This policy governs the collection, security, and use of staff attendance data for necessary business operations.",
                        style: TextStyle(fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 15),
                      
                      _buildPolicySection("1. Data Collection & Purpose", [
                        "Data Collected: Name/ID, clock-in/out times, location (if applicable), hours worked, and absence records.",
                        "Purpose: Exclusively for payroll, benefits, labor law compliance, workforce management, and emergency security.",
                        "Transparency: Staff are informed of tracking methods. Explicit consent is required for biometric data use.",
                      ]),
                      
                      const SizedBox(height: 15),
                      
                      _buildPolicySection("2. Security Measures", [
                        "Encryption: Data is encrypted at rest and in transit (e.g., using AES-256 and SSL/TLS).",
                        "Access Control (RBAC): Access is strictly limited on a need-to-know basis (HR/Payroll, Managers for direct reports, audited IT access).",
                        "Authentication: All users must use Multi-Factor Authentication (MFA/2FA) and strong passwords.",
                        "Audits: System logs are monitored and audited to detect unauthorized access.",
                      ]),
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

  // Helper to build sections with bullet points
  Widget _buildPolicySection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}