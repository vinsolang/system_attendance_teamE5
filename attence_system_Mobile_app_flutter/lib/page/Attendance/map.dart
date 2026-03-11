import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;

  static const LatLng _location =
      LatLng(11.5564, 104.9282); // Phnom Penh example

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFFF9F7FA);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 60), // balance spacing
                ],
              ),
            ),

            // Map
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: _location,
                          zoom: 17,
                        ),
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                        markers: {
                          const Marker(
                            markerId: MarkerId('main_location'),
                            position: _location,
                          ),
                        },
                      ),

                      // Locate Me Button
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            _mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                const CameraPosition(
                                  target: _location,
                                  zoom: 17,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}