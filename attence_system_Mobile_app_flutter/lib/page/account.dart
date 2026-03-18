import 'dart:convert';
import 'dart:typed_data';
import 'package:attence_system/services/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class AccountScreen extends StatefulWidget {
  final String userEmail;

  const AccountScreen({super.key, required this.userEmail});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? employeeDbId;
  String? serverImageUrl;
  bool isLoading = true;

  XFile? pickedImage;
  Uint8List? webImagePreview;

  String get baseUrl {
    if (kIsWeb) return "http://localhost:8080";
    return "${ApiConfig.baseUrl}"; // Android emulator
  }

  /// Controllers
  final TextEditingController khmerNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  /// Pick Image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        pickedImage = image;
        webImagePreview = bytes;
      });
    }
  }

  /// Load profile
  Future<void> loadProfile() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/employees/${widget.userEmail}"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          employeeDbId = data['id'].toString();
          serverImageUrl = data['profileImageUrl'];

          khmerNameController.text = data['khmerName'] ?? '';
          englishNameController.text = data['fullName'] ?? '';
          genderController.text = data['gender'] ?? '';
          relationshipController.text = data['relationshipStatus'] ?? '';
          birthController.text = data['birthDate'] ?? '';
          phoneController.text = data['phoneNumber'] ?? '';
          emailController.text = data['email'] ?? '';

          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Load Error: $e");
    }
  }

  /// Update profile
  Future<void> updateProfile() async {
    if (employeeDbId == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("$baseUrl/api/employees/$employeeDbId"),
      );

      request.fields['khmerName'] = khmerNameController.text;
      request.fields['gender'] = genderController.text;
      request.fields['relationshipStatus'] = relationshipController.text;
      request.fields['birthDate'] = birthController.text;
      request.fields['phoneNumber'] = phoneController.text;
      request.fields['fullName'] = englishNameController.text;
      request.fields['email'] = emailController.text;

      if (pickedImage != null && webImagePreview != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'profileImage',
            webImagePreview!,
            filename: "profile.jpg",
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      var response = await request.send();

      Navigator.pop(context);

      if (response.statusCode == 200) {
        loadProfile();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfully")),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      print("Update Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [

                  /// HEADER WITH BACK BUTTON
                  Stack(
                    children: [

                      /// HEADER DESIGN
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 80, bottom: 30),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff4A6CF7), Color(0xff6A8DFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),

                        child: Column(
                          children: [

                            /// PROFILE IMAGE
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,

                                  backgroundImage: webImagePreview != null
                                      ? MemoryImage(webImagePreview!)
                                      : (serverImageUrl != null &&
                                              serverImageUrl!.isNotEmpty)
                                          ? NetworkImage(
                                              "$baseUrl/$serverImageUrl")
                                          : null,

                                  child: (webImagePreview == null &&
                                          (serverImageUrl == null ||
                                              serverImageUrl!.isEmpty))
                                      ? const Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),

                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            Text(
                              englishNameController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              emailController.text,
                              style:
                                  const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      /// BACK BUTTON
                      Positioned(
                        top: 40,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [

                        buildCardSection("Personal Information", [
                          buildTextField("Khmer Name", khmerNameController),
                          buildTextField(
                            "English Name",
                            englishNameController,
                            readOnly: true,
                          ),
                          buildTextField("Gender", genderController),
                          buildTextField(
                              "Relationship Status",
                              relationshipController),
                          buildTextField("Date of Birth", birthController),
                        ]),

                        const SizedBox(height: 20),

                        buildCardSection("Contact Information", [
                          buildTextField("Phone Number", phoneController),
                          buildTextField(
                            "Email",
                            emailController,
                            readOnly: true,
                          ),
                        ]),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: updateProfile,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: const Color(0xff4A6CF7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// CARD SECTION
  Widget buildCardSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  /// TEXT FIELD
  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: readOnly ? Colors.grey.shade100 : Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}