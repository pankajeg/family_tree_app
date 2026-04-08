import '../../../../core/constants/url_constants.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/service/api_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _apiService.post(
      UrlConstants.authLogin,
      body: request.toJson(),
    );

    if (response.data is! Map<String, dynamic>) {
      throw const ApiException('Invalid login response format');
    }

    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
