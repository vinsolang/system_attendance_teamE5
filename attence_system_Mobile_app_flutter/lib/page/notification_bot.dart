import 'package:flutter/material.dart';

class NotificationBotPage extends StatefulWidget {
  const NotificationBotPage({super.key});

  @override
  State<NotificationBotPage> createState() => _NotificationBotPageState();
}

class _NotificationBotPageState extends State<NotificationBotPage> {
  bool isActivities = true; // Toggle between Activities and Announcement
  String selectedFilter = "All";

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
          "Notification Bot",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- Main Toggle (Activities / Announcement) ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _buildMainToggleItem(
                    "Activities",
                    isActivities,
                    () => setState(() => isActivities = true),
                  ),
                  _buildMainToggleItem(
                    "Announcement",
                    !isActivities,
                    () => setState(() => isActivities = false),
                  ),
                ],
              ),
            ),
          ),

          // --- Sub-filters (Only shown for Activities) ---
          if (isActivities)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ["All", "Leave", "Overtime", "Payslip"].map((filter) {
                  bool isSelected = selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (val) =>
                          setState(() => selectedFilter = filter),
                      selectedColor: Colors.black,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      shape: StadiumBorder(),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),

          // --- Notification List ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: isActivities
                  ? _buildActivityList()
                  : _buildAnnouncementList(),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for top pill toggle
  Widget _buildMainToggleItem(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActivityList() {
    return [
      const Text(
        "November 2025",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      _notificationCard(
        "Sao Darith",
        "approved your overtime payment request",
        "7 days ago",
        isAvatar: true,
      ),
      _notificationCard(
        "Sao Darith",
        "approved your overtime payment request",
        "7 days ago",
        isAvatar: true,
      ),
      const SizedBox(height: 10),
      const Text(
        "October 2025",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      _notificationCard(
        "Sao Darith",
        "approved your overtime payment request",
        "7 days ago",
        isAvatar: true,
      ),
      _notificationCard(
        "Sao Darith",
        "approved your overtime payment request",
        "7 days ago",
        isAvatar: true,
      ),
    ];
  }

  List<Widget> _buildAnnouncementList() {
    return [
      _notificationCard(
        "Internal Announcement:",
        "Training for new staff...",
        "3 days ago",
        isIcon: true,
      ),
      _notificationCard(
        "Welcome New Employee:",
        "onboarding session...",
        "7 days ago",
        isIcon: true,
      ),
      _notificationCard(
        "Employee Super star 2025:",
        "Congratulations to...",
        "10 days ago",
        isIcon: true,
      ),
      _notificationCard(
        "Call for Registration:",
        "Health checkup...",
        "November 19",
        isIcon: true,
      ),
    ];
  }

  Widget _notificationCard(
    String title,
    String subtitle,
    String time, {
    bool isAvatar = false,
    bool isIcon = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[200],
          child: isIcon
              ? const Icon(Icons.campaign, color: Colors.black54)
              : const Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ), // Replace with Image.asset for real avatars
        ),
        title: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "$title ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: subtitle),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
