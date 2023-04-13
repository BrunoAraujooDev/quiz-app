class HttpError implements Exception {
  final int statusCode;
  final String message;

  HttpError({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
