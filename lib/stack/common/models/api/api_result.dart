import '../../errors/api/api_error.dart';
import '../result.dart';

class ApiResult<TValue extends Object> extends Result<TValue, ApiError> {
  const ApiResult.success({super.value}) : super.internal();

  const ApiResult.failure(ApiError error) : super.internal(error: error);
}
