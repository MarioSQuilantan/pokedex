class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;

  NetworkException({required this.message, this.statusCode, this.data});
}
