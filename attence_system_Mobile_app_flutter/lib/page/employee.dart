class Employee {
  final String fullName;
  final String employeeId;
  // final String? position;
  final String? profileImageUrl;

  Employee({
    required this.fullName,
    required this.employeeId,
    // this.position,
    this.profileImageUrl,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      fullName: json['fullName'] ?? '',
      employeeId: json['employeeId'] ?? '',
      // position: json['position'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}