import 'package:flutter/material.dart';

/// Constants to be used throughout the app
class Constants {
  Constants._(); // Private constructor to prevent instantiation

  // App Information
  static const String appName = 'Spatial Share';
  static const String appVersion = '1.0.0';
  static const String copyright = '© 2025 Spatial Inc. All Rights Reserved.';

  // User Information (you can update this dynamically)
  static const String userName = 'Aarav';
  static const String greeting = 'Hello 👋, Welcome Back!';

  // Network Timeout
  static const Duration requestTimeout = Duration(seconds: 30);

  // Default Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  );

  // Animation Durations
  static const Duration fadeDuration = Duration(milliseconds: 300);
  static const Duration slideDuration = Duration(milliseconds: 400);

  // Icons
  static const IconData sendIcon = Icons.send_rounded;
  static const IconData receiveIcon = Icons.download_rounded;
  static const IconData fileIcon = Icons.folder_rounded;
  static const IconData settingsIcon = Icons.settings_rounded;

  // Images
  static const String logoPath = 'assets/logo/spatial_logo.png';
  static const String userProfile = 'assets/images/user_avatar.png';

  // API Endpoints (Placeholder)
  static const String apiBaseUrl = 'https://api.spatialshare.com';
  static const String uploadEndpoint = '$apiBaseUrl/upload';
  static const String downloadEndpoint = '$apiBaseUrl/download';
  static const String fileListEndpoint = '$apiBaseUrl/files';
}

