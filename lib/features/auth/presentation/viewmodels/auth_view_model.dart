import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/providers/network_providers.dart';
import '../../../../core/presentation/viewmodels/base_view_model.dart';
import '../../../../core/storage/providers/storage_providers.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_use_case.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.read(apiServiceProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider)),
);

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, LoginResponse?>(
  AuthViewModel.new,
);

class AuthViewModel extends BaseViewModel<LoginResponse?> {
  @override
  LoginResponse? build() {
    return null;
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await executeAndGet(
      () => ref.read(loginUseCaseProvider).call(
            LoginRequest(email: email, password: password),
          ),
    );

    if (response == null) {
      final currentError = error;
      if (currentError is Exception) {
        throw currentError;
      }
      throw Exception(currentError?.toString() ?? 'Login failed');
    }

    await ref
        .read(storageServiceProvider)
        .saveToken(response.data.accessToken);

    return response;
  }
}
