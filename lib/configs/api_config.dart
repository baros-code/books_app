import 'package:books_app/stack/common/models/api/api_setup_params.dart';

class ApiConfig {
  static const String baseUrl = 'https://www.googleapis.com';
  static const String apiKey = 'AIzaSyBZM1yCKKF7USHU9bOgb4fMyis4FaLoV8s';

  static ApiSetupParams get setupParams => ApiSetupParams(
        baseUrl: baseUrl,
        retryCount: 1,
      );
}
