import 'package:flutter/material.dart';


class LeaveReportPage extends StatefulWidget {
  const LeaveReportPage({super.key});

  @override
  State<LeaveReportPage> createState() => _LeaveReportPageState();
}

class _LeaveReportPageState extends State<LeaveReportPage> {
  bool showFullSummary = false;

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
          "Leave Report",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1E6F2).withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: showFullSummary ? _buildFullMonthlySummary() : _buildMainReport(),
        ),
      ),
    );
  }

  // --- VIEW 1: Main Report with Progress Bars ---
  Widget _buildMainReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("2025 Leave Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Used / Remain", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 20),
          _buildLeaveBar("Annual Leave", 5.5, 0.5, color: Colors.blueAccent),
          _buildLeaveBar("Carry Forward 2024", 0, 0),
          _buildLeaveBar("Carry Forward 2023", 0, 0),
          _buildLeaveBar("Carry Forward 2022", 0, 0),
          _buildLeaveBar("Sick Leave", 0, 0),
          _buildLeaveBar("Hospitalization Leave", 0, 0),
          _buildLeaveBar("Special Leave", 0, 0),
          _buildLeaveBar("Maternity Leave", 0, 90),
          
          const SizedBox(height: 40),
          const Text("Monthly Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ListTile(
            title: const Text("January"),
            trailing: const Text("Total: 0 Day >"),
            onTap: () => setState(() => showFullSummary = true),
          ),
        ],
      ),
    );
  }

  // --- VIEW 2: Full Monthly Summary List ---
  Widget _buildFullMonthlySummary() {
    final months = [
      {"name": "February", "total": "0 Day"},
      {"name": "March", "total": "0 Day"},
      {"name": "April", "total": "0 Day"},
      {"name": "May", "total": "0 Day"},
      {"name": "June", "total": "0 Day"},
      {"name": "July", "total": "0 Day"},
      {"name": "August", "total": "0 Day"},
      {"name": "September", "total": "0 Day"},
      {"name": "October", "total": "0 Day"},
      {"name": "November", "total": "3.5 Days"},
      {"name": "December", "total": "1 Day"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => showFullSummary = false)),
              const Text("Monthly Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: months.length,
            itemBuilder: (context, index) {
              bool isEven = index % 2 == 0;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isEven ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(months[index]["name"]!),
                  trailing: Text("Total: ${months[index]["total"]} >", style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper to build the balance bars
  Widget _buildLeaveBar(String title, double used, double remain, {Color color = Colors.grey}) {
    double total = used + remain;
    double progress = total == 0 ? 0 : used / total;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Text("$used/$remain", style: const TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(used > 0 ? color : Colors.grey[400]!),
            ),
          ),
        ],
      ),
    );
  }
}