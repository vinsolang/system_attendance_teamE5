import 'dart:convert';
import 'package:attence_system/services/api_config.dart';
import 'package:http/http.dart' as http;

class AttendanceService {
  final String baseUrl = "${ApiConfig.baseUrl}/api/attendance";

  // --- Check-in ---
  Future<Map<String, dynamic>?> checkIn(int employeeId) async {
    final url = Uri.parse('$baseUrl/checkin/$employeeId?device=MOBILE');
    final res = await http.post(url);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to check-in');
    }
  }

  // --- Check-out ---
  Future<Map<String, dynamic>?> checkOut(int employeeId) async {
    final url = Uri.parse('$baseUrl/checkout/$employeeId?device=MOBILE');
    final res = await http.post(url);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to check-out');
    }
  }

  // --- Get today attendance ---
  Future<Map<String, dynamic>?> getToday(int employeeId) async {
    final url = Uri.parse('$baseUrl/today/$employeeId');
    final res = await http.get(url);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return jsonDecode(res.body);
    }
    return null; // no record yet
  }

  // --- Get attendance history ---
  Future<List<dynamic>> getHistory(int employeeId) async {
    final url = Uri.parse('$baseUrl/history/$employeeId');
    final res = await http.get(url);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return jsonDecode(res.body);
    }
    return [];
  }
}