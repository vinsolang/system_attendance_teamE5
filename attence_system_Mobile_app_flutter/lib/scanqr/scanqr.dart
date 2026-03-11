import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final MobileScannerController controller = MobileScannerController();
  final ImagePicker picker = ImagePicker();

  bool isFlashOn = false;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              const Text(
                'Scan QR',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 SCANNER AREA
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: selectedImage == null
                      ? MobileScanner(
                          controller: controller,
                          onDetect: (barcodeCapture) {
                            final barcode = barcodeCapture.barcodes.first;
                            if (barcode.rawValue != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('QR: ${barcode.rawValue}'),
                                ),
                              );
                            }
                          },
                        )
                      : Image.file(selectedImage!, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScanAction(
                    Icons.flashlight_on,
                    'Flash',
                    _toggleFlash,
                  ),
                  const SizedBox(width: 40),
                  _buildScanAction(
                    Icons.file_upload_outlined,
                    'Upload',
                    _pickImage,
                  ),
                ],
              ),

              const Spacer(),

              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                label: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Flash Toggle
  void _toggleFlash() async {
    await controller.toggleTorch();
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  // 🔹 Pick Image from Gallery
  Future<void> _pickImage() async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Widget _buildScanAction(
      IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}































// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart'; // Camera & Flash logic
// import 'package:image_picker/image_picker.dart';      // Upload logic

// class ScanQRScreen extends StatefulWidget {
//   const ScanQRScreen({super.key});

//   @override
//   State<ScanQRScreen> createState() => _ScanQRScreenState();
// }

// class _ScanQRScreenState extends State<ScanQRScreen> {
//   // Controller to manage camera and flash
//   final MobileScannerController controller = MobileScannerController();
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   // --- Logic for Upload Button ---
//   Future<void> _uploadFromGallery() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       // Logic to analyze the image for a QR code would go here
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image selected: ${image.name}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F6FA),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 60),
//               const Center(
//                 child: Text('Scan QR', 
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(height: 40),

//               // --- SCANNER AREA ---
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(25),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.03),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   children: [
//                     // LIVE CAMERA VIEW
//                     Container(
//                       height: 250,
//                       width: 250,
//                       clipBehavior: Clip.hardEdge,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: MobileScanner(
//                         controller: controller,
//                         onDetect: (capture) {
//                           final List<Barcode> barcodes = capture.barcodes;
//                           for (final barcode in barcodes) {
//                             debugPrint('Barcode found! ${barcode.rawValue}');
//                             // Handle navigation or data processing here
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 30),

//                     // ACTION BUTTONS
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // FLASH BUTTON
//                         _buildScanAction(
//                           icon: Icons.flashlight_on,
//                           label: 'Flash',
//                           onTap: () => controller.toggleTorch(),
//                         ),
//                         const SizedBox(width: 40),
//                         // UPLOAD BUTTON
//                         _buildScanAction(
//                           icon: Icons.file_upload_outlined,
//                           label: 'Upload',
//                           onTap: _uploadFromGallery,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               _buildBackButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScanAction({required IconData icon, required String label, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(color: Color(0xFFE0E0E0), shape: BoxShape.circle),
//             child: Icon(icon, color: Colors.black87, size: 28),
//           ),
//           const SizedBox(height: 8),
//           Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   Widget _buildBackButton(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 20.0),
//         child: TextButton.icon(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
//           label: const Text('Back', style: TextStyle(color: Colors.black, fontSize: 18)),
//         ),
//       ),
//     );
//   }
// }