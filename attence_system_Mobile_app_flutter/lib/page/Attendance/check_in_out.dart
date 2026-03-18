import 'dart:async';
import 'package:flutter/material.dart';
import 'package:attence_system/page/Attendance/attendance_service.dart';
import 'package:intl/intl.dart'; // For date formatting


class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int statusStep = 0; // 0 = Initial, 1 = Checked-in, 2 = Checked-out
  String checkInTime = "-";
  String checkOutTime = "-";
  String currentTime = "-";
  List<dynamic> history = [];

  final int employeeId = 1; // Replace with logged-in employee ID
  final AttendanceService api = AttendanceService();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadAttendance();
    _startCurrentTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Update current time every second
  void _startCurrentTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        currentTime = DateFormat('HH:mm:ss').format(now);
      });
    });
  }

  // Load today's attendance and history
  void _loadAttendance() async {
    try {
      final today = await api.getToday(employeeId);
      if (today != null) {
        setState(() {
          checkInTime = today['checkInTime'] != null
              ? today['checkInTime'].substring(11, 16)
              : "-";
          checkOutTime = today['checkOutTime'] != null
              ? today['checkOutTime'].substring(11, 16)
              : "-";
          statusStep = checkInTime != "-" ? (checkOutTime != "-" ? 2 : 1) : 0;
        });
      }

      final hist = await api.getHistory(employeeId);
      setState(() {
        history = hist ?? [];
      });
    } catch (e) {
      print("Error loading attendance: $e");
    }
  }

  // Handle check-in/out button
  void _handleTap() async {
    try {
      if (statusStep == 0) {
        final res = await api.checkIn(employeeId);
        if (res != null) {
          setState(() {
            checkInTime = res['checkInTime'].substring(11, 16);
            statusStep = 1;
          });
        }
      } else if (statusStep == 1) {
        final res = await api.checkOut(employeeId);
        if (res != null) {
          setState(() {
            checkOutTime = res['checkOutTime'].substring(11, 16);
            statusStep = 2;
          });
        }
      }

      // Refresh history after action
      final hist = await api.getHistory(employeeId);
      setState(() {
        history = hist ?? [];
      });
    } catch (e) {
      print("Error performing attendance action: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6),
      appBar: AppBar(title: const Text("My Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Main Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1E6F2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(todayDate,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(currentTime,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildAttendanceRow("Check-in:", checkInTime),
                  if (statusStep == 2) ...[
                    const SizedBox(height: 10),
                    _buildAttendanceRow("Check-out:", checkOutTime),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Check-in/out button
            if (statusStep < 2)
              GestureDetector(
                onTap: _handleTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Text(
                        statusStep == 0 ? "Check-in" : "Check-out",
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        currentTime, // show current time on button
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),

            const Spacer(),

            // History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Your Attendance",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  final date = item['checkInTime'].substring(0, 10);
                  final checkIn = item['checkInTime'].substring(11, 16);
                  final checkOut = item['checkOutTime'] != null
                      ? item['checkOutTime'].substring(11, 16)
                      : "-";

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(date),
                      subtitle: Row(
                        children: [
                          Text("In: $checkIn "),
                          Text("Out: $checkOut"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceRow(String label, String time) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.check, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ],
        ),
        Text(time,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
      ],
    );
  }
}