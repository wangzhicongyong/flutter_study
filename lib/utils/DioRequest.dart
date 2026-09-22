// 1.在DioRequest工具类中统一初始化网络请求常见配置,实现请求拦截器、响应拦截器以及错误处理
// 2.统一在service中管理接口请求,并且对返回的数据根据实际需求进行处理,如果数据的修改 需要更新UI或者 需要全局共享该数据,可以结合provider实现

import 'package:dio/dio.dart';
/// dio网络请求配置表 自定义
class DioConfig {
  // 声明变量赋值
  static const baseURL = 'http://117.34.71.31:8081/paas-admin'; //域名
  static const timeout = 10000; //超时时间
} 
// 网络请求工具类
class DioRequest {

  late Dio dio;
  static DioRequest? _instance;

  /// 构造函数
  DioRequest() {
    dio = Dio();
    dio.options = BaseOptions(
        baseUrl: DioConfig.baseURL,
        connectTimeout: Duration(seconds: DioConfig.timeout),
        sendTimeout: Duration(seconds: DioConfig.timeout),
        receiveTimeout: Duration(seconds: DioConfig.timeout),
        contentType: 'application/json; charset=utf-8',
        headers: {});

    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print("\n");
      handler.next(response);
    }, onError: (DioError e, handler) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("\n");
      return handler.next(e);
    }));
  }
  static DioRequest getInstance() {
    // 如果_
    return _instance ??= DioRequest();
  }
}