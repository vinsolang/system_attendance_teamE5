import 'package:attence_system/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {

  String selectedType = "Annual leave";
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController reasonController = TextEditingController();

  //  API URL (change to your backend)
  final String apiUrl = "${ApiConfig.baseUrl}/api/leaves";

  // ===================== DATE PICKER =====================
  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime initial = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  // ===================== SUBMIT =====================
  Future<void> submitRequest() async {
    if (startDate == null || endDate == null || reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final body = {
      "type": selectedType,
      "startDate": DateFormat('yyyy-MM-dd').format(startDate!),
      "endDate": DateFormat('yyyy-MM-dd').format(endDate!),
      "reason": reasonController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Request submitted successfully")),
        );

        Navigator.pop(context); // go back
      } else {
        throw Exception("Failed");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F7),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Apply for leave',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F4F9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text('Request type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                const SizedBox(height: 15),

                Row(
                  children: [
                    _buildTypeButton('Annual leave'),
                    _buildTypeButton('Sick Leave'),
                    _buildTypeButton('Over Time'),
                  ],
                ),

                const SizedBox(height: 25),

                const Text('Date'),
                const SizedBox(height: 10),

                _buildDateField(
                  "Start Date",
                  startDate,
                  () => pickDate(context, true),
                ),

                const SizedBox(height: 10),

                _buildDateField(
                  "End Date",
                  endDate,
                  () => pickDate(context, false),
                ),

                const SizedBox(height: 25),

                const Text('Reason'),
                const SizedBox(height: 10),

                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFE5E0E5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text("Submit Request"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================== COMPONENTS =====================
  Widget _buildTypeButton(String label) {
    bool isSelected = selectedType == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = label;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E0E5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null
                  ? label
                  : DateFormat('dd MMM yyyy').format(date),
            ),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}