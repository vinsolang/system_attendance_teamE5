import 'dart:async';

import 'package:attence_system/auth/logout.dart';
import 'package:attence_system/page/Attendance/check-in.dart';
import 'package:attence_system/page/aboutpage.dart';
import 'package:attence_system/page/account.dart';
import 'package:attence_system/page/helpsupport.dart';
import 'package:attence_system/page/privacy.dart';
import 'package:attence_system/page/teamcondition.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Remove the global fetchProfile function and move it inside _HomeScreenState

class HomeScreen extends StatefulWidget {
  final String userEmail; // Add this
  const HomeScreen({super.key, required this.userEmail}); // Add this

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCategorySelected = true;
  String fullName = '';
  String profileImage = '';

  Future<void> fetchUser() async {
    try {
      // Use widget.userEmail to get the value passed to the widget
      final response = await http.get(
        Uri.parse("http://192.168.3.26:8080/api/employees/${widget.userEmail}"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          fullName = data['fullName'] ?? 'No Name';
          profileImage = data['profileImageUrl'] ?? '';
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Connection Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF3F2F8);
    const Color accentColor = Color(0xFF333333);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            _buildProfileHeader(accentColor),

            const SizedBox(height: 10),

            // --- FUNCTIONAL TOGGLE BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Tap to show Category
                    _buildToggleItem(
                      "Category...",
                      isActive: isCategorySelected,
                      onTap: () => setState(() => isCategorySelected = true),
                    ),
                    // Tap to show Setting
                    _buildToggleItem(
                      "Setting...",
                      isActive: !isCategorySelected,
                      onTap: () => setState(() => isCategorySelected = false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- FILTERED CONTENT ---
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 300,
                ), // Smooth transition
                child: isCategorySelected
                    ? _buildCategoryGrid()
                    : _buildSettingsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // --- WIDGET: PROFILE HEADER ---
 Widget _buildProfileHeader(Color accentColor) {
  // Logic to get initials
  String initial = "?";
  if (fullName.isNotEmpty) {
    initial = fullName[0].toUpperCase();
  }
  

  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 40, 25, 20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: Colors.black,
          // Check if string is not empty
          backgroundImage: (profileImage.isNotEmpty)
              ? NetworkImage("http://192.168.3.26:8080/$profileImage")
              : null,
          child: (profileImage.isEmpty)
              ? Text(
                  initial,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                )
              : null,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName.isNotEmpty ? fullName : "Loading...",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: accentColor),
            ),
            const Text('CNP Company Co.Ltd', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}

  // --- WIDGET: CATEGORY GRID (HOME) ---
  Widget _buildCategoryGrid() {
    return Container(
      key: const ValueKey(1), // Key helps AnimatedSwitcher identify the change
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: [
          _buildPremiumCard(
            Icons.calendar_today_rounded,
            'My Attendance',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AttendanceApp(),
                ),
              );
            },
          ),

          _buildPremiumCard(
            Icons.folder_copy_rounded,
            'My Leave',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignOutScreen()),
              );
            },
          ),

          _buildPremiumCard(
            Icons.description_rounded,
            'Leave Report',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignOutScreen(),
                ),
              );
            },
          ),

          _buildPremiumCard(
            Icons.auto_awesome_rounded,
            'Notification Bot',
            onTap: () {},
          ),

          _buildPremiumCard(Icons.event_note_rounded, 'Calendar', onTap: () {}),

          _buildPremiumCard(Icons.face_6_rounded, 'Member', onTap: () {}),
        ],
      ),
    );
  }

  // --- WIDGET: SETTINGS LIST ---
  Widget _buildSettingsList() {
    return Container(
      key: const ValueKey(2),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          _buildSettingTile(
            Icons.person_outline,
            'Account',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(
                    // Replace 'user@example.com' with your actual email variable
                    userEmail: widget.userEmail, 
                  ),
                ),
              );
            },
          ),
          _buildSettingTile(
            Icons.lock_outline,
            'Privacy & Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacySecurityScreen(),
                ),
              );
            },
          ),
          _buildSettingTile(
            Icons.headset_mic_outlined,
            'Help and Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen(),
                ),
              );
            },
          ),
          _buildSettingTile(
            Icons.info_outline,
            'About',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()),
              );
            },
          ),

          // --- NAVIGATE TO SIGN OUT PAGE ---
          _buildSettingTile(
            Icons.logout,
            'Sign out',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignOutScreen()),
              );
            },
          ),

          _buildSettingTile(
            Icons.search,
            'Terms and conditions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsConditionsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- HELPERS ---

  Widget _buildToggleItem(
    String title, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCard(
    IconData icon,
    String label, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Add "required VoidCallback onTap" inside the curly braces {}
  Widget _buildSettingTile(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap, // Now this will use the function you pass from the list
    );
  }
}
