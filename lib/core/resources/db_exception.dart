class DbException implements Exception {
  final String message;

  DbException({required this.message});
}
