class WeatherLocationException implements Exception {
  String? message;
  @override
  String toString() {
    if (message == null) {
      return 'No message';
    }
    return message!;
  }
}
