import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyRequestPage extends StatefulWidget {
  const MyRequestPage({super.key});

  @override
  State<MyRequestPage> createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<MyRequestPage> {
  bool isInProgress = true;

  List requests = [];
  bool isLoading = true;

  final String apiUrl = "http://192.168.3.26:8080/api/leaves";

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  // ================= FETCH DATA =================
  Future<void> fetchRequests() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          requests = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // ================= FILTER =================
  List get inProgress =>
      requests.where((e) => e["status"] == "PENDING").toList();

  List get history =>
      requests.where((e) => e["status"] != "PENDING").toList();

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F7),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context), // ✅ FIXED
        ),
        title: const Text(
          'My Request',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F4F9),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildToggleSwitch(),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TOGGLE =================
  Widget _buildToggleSwitch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isInProgress = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isInProgress ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "In-Progress",
                    style: TextStyle(
                      color: isInProgress ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isInProgress = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isInProgress ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "History",
                    style: TextStyle(
                      color: !isInProgress ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= LIST =================
  Widget _buildList() {
    final data = isInProgress ? inProgress : history;

    if (data.isEmpty) {
      return const Center(child: Text("No requests found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final req = data[index];

        return _buildRequestCard(req);
      },
    );
  }

  // ================= CARD =================
  Widget _buildRequestCard(dynamic req) {
    String status = req["status"];

    Color statusColor = status == "APPROVED"
        ? Colors.green
        : status == "REJECTED"
            ? Colors.red
            : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4EB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(req["type"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            "${req["startDate"]} → ${req["endDate"]}",
            style: TextStyle(color: Colors.grey[700]),
          ),

          const SizedBox(height: 8),

          Text(
            req["reason"] ?? "",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}