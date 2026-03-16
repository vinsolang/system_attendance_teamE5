class Employee {
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final String role;

  Employee({required this.fullName, required this.email, this.profileImageUrl, required this.role});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      fullName: json['fullName'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      role: json['role'],
    );
  }
}