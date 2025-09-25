import 'package:dio/dio.dart';

import '../core.dart';

class DioNetworkExceptionHandlerUtil {
  static NetworkException handle(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage = _extractServerMessage(e);

    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return NetworkException(message: serverMessage ?? 'No internet connection', statusCode: statusCode);

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        return NetworkException(message: serverMessage ?? 'Timeout response', statusCode: statusCode);

      case DioExceptionType.badResponse:
        return NetworkException(message: serverMessage ?? 'Bad response', statusCode: statusCode);

      default:
        return NetworkException(message: serverMessage ?? 'Unknown error', statusCode: statusCode);
    }
  }

  static String? _extractServerMessage(DioException e) {
    try {
      if (e.response?.data is Map) {
        return (e.response?.data as Map)['message']?.toString();
      }
    } catch (_) {}
    return e.message;
  }
}
