import 'package:books_app/stack/common/models/api/api_setup_params.dart';

class ApiConfig {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'YOUR_API_KEY';

  static ApiSetupParams get setupParams => ApiSetupParams(
        baseUrl: baseUrl,
        retryCount: 1,
      );
}
