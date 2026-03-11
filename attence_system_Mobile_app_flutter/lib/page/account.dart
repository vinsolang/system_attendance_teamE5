import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios, size: 18),
                        Text("Back", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  const Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 50), // Balancing spacer
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // --- PROFILE IMAGE ---
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, size: 80, color: Colors.white),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt_outlined, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- INFORMATION SECTIONS ---
                    _buildInfoSection("Personal Information", [
                      _buildInfoField("Khmer Name", "វិន​ សុឡាង"),
                      _buildInfoField("English Name", "Vin Solang"),
                      _buildInfoField("Gender", "Male"),
                      _buildInfoField("Relationship Status", "Single"),
                      _buildInfoField("Date of Birth", "07-23-2000"),
                    ]),

                    _buildInfoSection("Work Information", [
                      _buildInfoField("Residency", "Resident"),
                      _buildInfoField("Department", "Computer Cience"),
                      _buildInfoField("Position", "Web Developer"),
                      _buildInfoField("Joined Date", "02-06-2023"),
                      _buildInfoField("Employment Type", "Full Time"),
                    ]),

                    _buildInfoSection("Contact Information", [
                      _buildInfoField("ID Card", "001111"),
                      _buildInfoField("Phone Number", "+8859768*******"),
                      _buildInfoField("Email", "vinsolang9@gmail.com"),
                    ]),
                    
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

  // Helper to build section headers and groups
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }

  // Helper to build individual data rows
  Widget _buildInfoField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.08))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}