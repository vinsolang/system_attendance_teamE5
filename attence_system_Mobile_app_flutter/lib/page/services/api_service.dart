// services/api_service.dart
import 'dart:convert';
import 'package:attence_system/page/employee_model.dart';
import 'package:attence_system/services/api_config.dart';
import 'package:http/http.dart' as http;

Future<List<Employee>> fetchEmployees() async {
  final response = await http.get(
    Uri.parse("${ApiConfig.baseUrl}/api/employees"),
  );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((e) => Employee.fromJson(e)).toList();
  } else {
    throw Exception("Failed to load employees");
  }
}