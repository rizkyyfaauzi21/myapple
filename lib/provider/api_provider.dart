class ApiConfig {
  // Base URLs
  // static const String baseApiUrl = 'http://10.0.2.2:8000/api';
  // static const String baseStorageUrl = 'http://10.0.2.2:8000/storage';

  static const String baseApiUrl = 'http://192.168.43.147:8000/api';
  static const String baseStorageUrl = 'http://192.168.43.147:8000/storage';

  // Storage paths
  static const String scanImagesPath = '$baseStorageUrl/images/scans/';
  static const String appleImagesPath = '$baseStorageUrl/images/apples';

  // API endpoints
  // static const String predictUrl = 'http://10.0.2.2:8001/predict';
  static const String predictUrl = 'http://192.168.43.147:8001/predict/';

  // Helper method for scan images
  static String getScanImageUrl(String imagePath) {
    return '$scanImagesPath/$imagePath';
  }

  // Helper method for apple images
  static String getAppleImageUrl(String imagePath) {
    return '$appleImagesPath/$imagePath';
  }
}
