

class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as int,
      message: json['msg'] as String? ?? '',
      data: _convert<T>(json['data']),
    );
  }

  bool get isSuccess => code == 0;

  static T? _convert<T>(dynamic data) {
    if (data == null) return null;
    // 这里可以根据 T 的类型做具体转换
    // 比如 if (T == User) return User.fromJson(data) as T;
    return data as T;
  }
}
