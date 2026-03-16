import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

// Mock imports - Replace with your actual file paths
// import 'package:attence_system/page/Attendance/map.dart';
// import 'package:attence_system/scanqr/scanqr.dart';

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

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // State variables
  bool isCheckedIn = false;
  String checkInTime = "--:--";
  String checkOutTime = "--:--";
  final String apiUrl = "http://192.168.3.26:8080/api/attendance/checkin";

  // Function to detect device type
  String getDeviceType(BuildContext context) {  
    if (kIsWeb) return "Web Browser";
    
    // Check for Tablet vs Mobile based on width
    double width = MediaQuery.of(context).size.width;
    if (Platform.isAndroid || Platform.isIOS) {
      return width > 600 ? "Tablet" : "Mobile Phone";
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return "Computer";
    }
    return "Unknown Device";
  }

  // Backend Integration Function
  Future<void> handleAttendance() async {
  final String currentTime = DateFormat('hh:mm a').format(DateTime.now());
  final String device = getDeviceType(context);

  try {

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": "EMP_001",
        "status": isCheckedIn ? "CHECK_OUT" : "CHECK_IN",
        "deviceType": device,
        "timestamp": DateTime.now().toIso8601String(),
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {

      setState(() {
        if (!isCheckedIn) {
          isCheckedIn = true;
          checkInTime = currentTime;
        } else {
          isCheckedIn = false;
          checkOutTime = currentTime;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server Error: ${response.body}")),
      );

    }

  } catch (e) {

    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Connection Error")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(isCheckedIn ? Icons.check_circle : Icons.radio_button_unchecked, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          isCheckedIn ? "Checked In" : "Not Checked In",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Action Section (Check-in / Check-out Button)
              Column(
                children: [
                  GestureDetector(
                    onTap: handleAttendance,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      decoration: BoxDecoration(
                        color: isCheckedIn ? Colors.redAccent : Colors.black,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            isCheckedIn ? "CHECK-OUT" : "CHECK-IN",
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(DateTime.now()),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Device detected: ${getDeviceType(context)}",
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
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
                  TextButton(onPressed: () {}, child: const Text("See More", style: TextStyle(color: Colors.black54))),
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
                      "Current Session",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeColumn("Check-in:", checkInTime),
                        _buildTimeColumn("Check-out:", checkOutTime),
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
        Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}