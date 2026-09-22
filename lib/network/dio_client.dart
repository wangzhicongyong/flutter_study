// dio 实例管理 单例

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/interceptors/auth_interceptor.dart';

class DioClient {
  // Dio 网络封装最经典的**懒汉单例**写法
  // static 静态变量 属于类本身 不属于对象实例 全局共享这一份变量
  // _instance代表私有变量 外部不能直接访问
  static DioClient? _instance;
  // 延迟赋值
  late final Dio _dio; 

  // 私有命名构造函数 禁止外部new实例 也是无参 函数体业务初始化
  DioClient._internal() {
    // 直接实例化对象
    _dio = Dio(BaseOptions(
      // 配置基础地址
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // 按需添加拦截器
    _dio.interceptors.addAll([
      // 自定义的
      // AuthInterceptor(),      // Token 自动注入 & 刷新
      LogInterceptor(          // 调试日志，生产环境可不加
        requestBody: true,
        responseBody: true,
        logPrint: (obj) {
          if (kDebugMode) debugPrint('[Dio] $obj');
        },
      ),
      // ErrorInterceptor(),      // 统一错误转换
    ]);
  }


  // =========1.单实例复用：整个项目共用同一个 Dio，复用连接池、拦截器
  // =========2.所有 Dio 配置、拦截器都在内部，外部只负责调用


  // 获取dioClient 实例
  static DioClient get instance {
    // ??= 空合并赋值：_instance为null时才创建
    _instance ??= DioClient._internal();
    return _instance!;
  }

  // 目的：**封装保护内部实例**，外部只能拿到这个 Dio 对象发请求，但不能直接替换 `_dio` 变量，防止实例被篡改
  // get 只读属性
  Dio get client => _dio;
  
  // final dioClient = DioClient();
  // 通过 getter 获取 dio 实例发起请求
  // final resp = await dioClient.client.get("/user");
}
