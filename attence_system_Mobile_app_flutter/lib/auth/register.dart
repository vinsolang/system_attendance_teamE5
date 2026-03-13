import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String role = "Employee";

  Future<bool> registerUser() async {
    try {

      // IMPORTANT: change localhost
      final url = Uri.parse('http://10.0.2.2:8080/api/auth/signup');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        // inside registerUser()
        body: jsonEncode({
          "firstName": firstNameController.text.trim(), // Added trim() to prevent trailing spaces
          "lastName": lastNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "role": role // Double check if your DTO uses "role" or "roles"
        }),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;

    } catch (e) {
      print("ERROR: $e");
      return false;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500)),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [

                const SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    Icon(Icons.person_add_alt_1_outlined, size: 40),

                    SizedBox(width: 10),

                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    children: [

                      buildInputField(
                        label: "First Name",
                        hint: "Enter first name",
                        controller: firstNameController,
                      ),

                      const SizedBox(height: 15),

                      buildInputField(
                        label: "Last Name",
                        hint: "Enter last name",
                        controller: lastNameController,
                      ),

                      const SizedBox(height: 15),

                      buildInputField(
                        label: "Email",
                        hint: "Enter email",
                        controller: emailController,
                      ),

                      const SizedBox(height: 15),

                      buildInputField(
                        label: "Password",
                        hint: "Enter password",
                        controller: passwordController,
                        isPassword: true,
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(

                          onPressed: () async {

                            bool success = await registerUser();

                            if(success){

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  const SnackBar(
                                      content: Text("Registered successfully")));

                              Navigator.pop(context);

                            }else{

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  const SnackBar(
                                      content: Text("Registration failed")));
                            }
                          },

                          child: const Text("Submit"),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                TextButton.icon(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  label: const Text("Back"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}