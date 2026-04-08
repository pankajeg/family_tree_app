import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../client/dio_client.dart';
import '../service/api_service.dart';
import '../service/dio_api_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return DioClient.build();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return DioApiService(ref.read(dioProvider));
});
