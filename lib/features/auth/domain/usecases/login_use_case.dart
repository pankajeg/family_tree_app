import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<LoginResponse> call(LoginRequest request) {
    return _authRepository.login(request);
  }
}
