class ApiResponse<T> {
  late String message;
  late bool status;
  List<T>? data;

  ApiResponse({
    required this.message,
    required this.status,
  });

  ApiResponse.listResponse({
    required this.message,
    required this.status,
    required this.data,
  });
}
