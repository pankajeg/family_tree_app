import 'package:dio/dio.dart';

import '../../constants/url_constants.dart';
import '../../logger/app_logger.dart';

class DioClient {
  DioClient._();

  static Dio build({
    BaseOptions? options,
    List<Interceptor>? interceptors,
  }) {
    final dio = Dio(
      options ??
          BaseOptions(
            baseUrl: UrlConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.extra['requestId'] ??= _createRequestId();
          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (object) => AppLogger.debug(object.toString()),
      ),
    );

    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }

  static String _createRequestId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return 'req_$now';
  }
}
