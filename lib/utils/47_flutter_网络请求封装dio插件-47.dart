

import 'package:dio/dio.dart';

void main(List<String> args) {
  
}

// 1.dio对象初始化千万别写在拦截器里面
final Dio _dio = Dio();

// - `handler.next()`：放行，继续走下一个拦截器 / 业务代码
// - `handler.reject(error)`：把响应标记为失败，上层 await 请求会抛出异常，进入 `catchError`
// - `handler.resolve(response)`：强制把请求当成成功返回（很少用）
// - ⚠️ 拦截器内**必须调用这三个其中一个**，否则请求挂起卡死

// 自定义拦截器 相当于中间件
class CustomInterceptor extends Interceptor {  

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      handler.next(response);
      return;
    }
    // 如果返回的状态码不是 200 报异常处理
    final err = DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
    handler.reject(err);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

// 使用 注册添加拦截器
void _addInterceptor() {
  _dio.interceptors.add(CustomInterceptor());

}