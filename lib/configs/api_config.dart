import 'package:books_app/stack/common/models/api/api_setup_params.dart';

class ApiConfig {
  static const String baseUrl = 'https://www.googleapis.com';

  static ApiSetupParams get setupParams => ApiSetupParams(
        baseUrl: baseUrl,
        retryCount: 1,
      );
}
