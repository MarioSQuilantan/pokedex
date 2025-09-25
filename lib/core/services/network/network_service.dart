import 'package:fpdart/fpdart.dart';

import '../../core.dart';

abstract interface class NetworkService {
  TaskEither<NetworkException, T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  });

  TaskEither<NetworkException, T> get<T>(String path, {Map<String, dynamic>? queryParameters, bool useToken = true});

  TaskEither<NetworkException, T> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  });

  TaskEither<NetworkException, T> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  });
}
