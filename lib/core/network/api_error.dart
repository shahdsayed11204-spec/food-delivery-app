class ApiError {

  final String message;
  final int ? StatusCode;

  ApiError({required this.message, this.StatusCode});

  @override

  String toString()
  {
    return message;
  }

}