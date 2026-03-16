import 'dart:io';
import 'package:flutter/foundation.dart';

String getDeviceType() {
  if (kIsWeb) return "Web Browser";
  if (Platform.isAndroid) return "Android Phone";
  if (Platform.isIOS) return "iPhone/iPad";
  if (Platform.isWindows || Platform.isMacOS) return "Computer";
  return "Unknown Device";
}