import 'package:dio/dio.dart';

import '../../logger/app_logger.dart';
import '../exceptions/api_exception.dart';
import '../models/api_response.dart';
import 'api_service.dart';

class DioApiService implements ApiService {
  DioApiService(this._dio);

  final Dio _dio;

  @override
  Future<ApiResponse<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _mapResponse(response);
    } on DioException catch (error) {
      AppLogger.apiError(error);
      throw _mapException(error);
    }
  }

  @override
  Future<ApiResponse<dynamic>> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _mapResponse(response);
    } on DioException catch (error) {
      AppLogger.apiError(error);
      throw _mapException(error);
    }
  }

  @override
  Future<ApiResponse<dynamic>> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _mapResponse(response);
    } on DioException catch (error) {
      AppLogger.apiError(error);
      throw _mapException(error);
    }
  }

  @override
  Future<ApiResponse<dynamic>> patch(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch<dynamic>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _mapResponse(response);
    } on DioException catch (error) {
      AppLogger.apiError(error);
      throw _mapException(error);
    }
  }

  @override
  Future<ApiResponse<dynamic>> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _mapResponse(response);
    } on DioException catch (error) {
      AppLogger.apiError(error);
      throw _mapException(error);
    }
  }

  ApiResponse<dynamic> _mapResponse(Response<dynamic> response) {
    final data = response.data;
    final message = data is Map<String, dynamic> ? data['message']?.toString() : null;

    return ApiResponse<dynamic>(
      data: data,
      statusCode: response.statusCode,
      message: message,
    );
  }

  ApiException _mapException(DioException error) {
    final response = error.response;
    final responseData = response?.data;

    final message = responseData is Map<String, dynamic>
        ? responseData['message']?.toString() ?? error.message ?? 'Unknown error'
        : error.message ?? 'Unknown error';

    return ApiException(
      message,
      statusCode: response?.statusCode,
    );
  }
}
