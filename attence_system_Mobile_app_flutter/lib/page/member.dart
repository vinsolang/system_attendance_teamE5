// pages/member_page.dart
import 'package:attence_system/page/employee_model.dart';
import 'package:attence_system/page/services/api_service.dart';
import 'package:flutter/material.dart';
import '../services/api_config.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  List<Employee> members = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    try {
      final data = await fetchEmployees();
      setState(() {
        members = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading employees: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> refreshEmployees() async {
    final data = await fetchEmployees();
    setState(() {
      members = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = members
        .where((e) =>
            e.fullName.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: const Text("Back", style: TextStyle(color: Colors.black)),
        ),
        title: const Text(
          "Members",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refreshEmployees,
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search members...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEBEBEB),
                      ),
                      onChanged: (val) {
                        setState(() {
                          searchQuery = val;
                        });
                      },
                    ),
                  ),
                  // Member List
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredMembers.length,
                      itemBuilder: (context, index) {
                        final emp = filteredMembers[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: (emp.profileImageUrl != null &&
                                        emp.profileImageUrl!.isNotEmpty)
                                    ? NetworkImage(
                                        "${ApiConfig.baseUrl}/${emp.profileImageUrl}")
                                    : null,
                                child: (emp.profileImageUrl == null ||
                                        emp.profileImageUrl!.isEmpty)
                                    ? Text(
                                        emp.fullName.isNotEmpty
                                            ? emp.fullName[0].toUpperCase()
                                            : "?",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      )
                                    : null,
                              ),
                              title: Text(emp.fullName),
                              // subtitle: Text(emp.position ?? "No position"), 
                              trailing: const Icon(Icons.keyboard_arrow_down),
                              onTap: () {
                                // Expand or show details if needed
                              },
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}