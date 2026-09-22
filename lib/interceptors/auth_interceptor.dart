// // token注入 刷新

// import 'package:dio/dio.dart';
// import 'package:flutter_application_1/network/dio_client.dart';

// // 自定义权限拦截器
// class AuthInterceptor extends Interceptor {
  
//   Future<String>? _refreshing; // 防止并发刷新

//   // 请求拦截
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // 本地存储中获取token
//     final token = TokenStore.getToken();

//     if (token != null) {
//       // 请求头添加token
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     // 放过
//     handler.next(options);
//   }

//   // 异常处理
//   @override
//   Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode != 401 || _isAuthApi(err.requestOptions.path)) {
//       return handler.next(err);
//     }

//     try {
//       final newToken = await _refreshAccessToken();
//       final opts = err.requestOptions;
//       opts.headers['Authorization'] = 'Bearer $newToken';
//       final retryResponse = await DioClient.instance.client.fetch(opts);
//       return handler.resolve(retryResponse);
//     } catch (e) {
//       // 刷新失败，跳转登录页
//       TokenStore.clear();
//       AuthState.instance.notifyUnauthenticated();
//       return handler.next(err);
//     }
//   }

//   Future<String> _refreshAccessToken() {
//     if (_refreshing != null) return _refreshing!;
//     final future = _doRefresh().whenComplete(() => _refreshing = null);
//     _refreshing = future;
//     return future;
//   }

//   bool _isAuthApi(String path) => path.contains('/auth/');
// }
