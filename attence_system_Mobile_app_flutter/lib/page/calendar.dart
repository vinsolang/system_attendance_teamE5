import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Sets initial date to "Today"
  DateTime selectedDate = DateTime.now();

  // Formatting helpers for the header
  final List<String> _weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  final List<String> _months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  String get _formattedDate {
    return "${_weekdays[selectedDate.weekday - 1]}, ${_months[selectedDate.month - 1]} ${selectedDate.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: const Text("Back", style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
        title: const Text("Calendar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1E6F2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select date", style: TextStyle(color: Colors.black54, fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formattedDate,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        const Icon(Icons.edit, color: Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.black12),

              // Calendar Grid with BLUE selection
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.blue, // <--- THIS SETS THE CIRCLE TO BLUE
                    onPrimary: Colors.white, // Color of the number inside the blue circle
                    onSurface: Colors.black, // Color of the other numbers
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => setState(() => selectedDate = DateTime.now()),
                      child: const Text("Clear", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, selectedDate),
                      child: const Text("OK", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}