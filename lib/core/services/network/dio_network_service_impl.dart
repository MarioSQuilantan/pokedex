import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';

@LazySingleton(as: NetworkService)
class DioNetworkServiceImpl implements NetworkService {
  final Dio dio;

  DioNetworkServiceImpl(this.dio);

  @override
  TaskEither<NetworkException, T> get<T>(String path, {Map<String, dynamic>? queryParameters, bool useToken = true}) {
    return TaskEither.tryCatch(() async {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data as T;
    }, (e, _) => _handleDioError(e));
  }

  @override
  TaskEither<NetworkException, T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    return TaskEither.tryCatch(() async {
      final response = await dio.post(path, data: data, queryParameters: queryParameters);
      return response.data as T;
    }, (e, _) => _handleDioError(e));
  }

  @override
  TaskEither<NetworkException, T> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    return TaskEither.tryCatch(() async {
      final response = await dio.put(path, data: data, queryParameters: queryParameters);
      return response.data as T;
    }, (e, _) => _handleDioError(e));
  }

  @override
  TaskEither<NetworkException, T> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    return TaskEither.tryCatch(() async {
      // final options = await _buildRequestOptions(useToken);

      final response = await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data as T;
    }, (e, _) => _handleDioError(e));
  }

  NetworkException _handleDioError(Object e) {
    if (e is DioException) {
      return DioNetworkExceptionHandlerUtil.handle(e);
    }
    return NetworkException(message: 'Unexpected error: ${e.toString()}');
  }
}
