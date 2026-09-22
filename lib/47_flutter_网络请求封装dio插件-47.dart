import 'package:dio/dio.dart';

void main(List<String> args) {}

// 程序执行的顺序
// === 字段声明初始化 → 初始化列表 `:` → 构造函数大括号 `{}`

// 封装dio工具类
class DioUtils {
  // 构造Dio对象 
  // 字段声明只能做简单赋值
  // 字段初始化（`final Dio _dio = Dio()`）在**构造函数体之前**执行
  final Dio _dio = Dio();  // 声明时直接实例化对象，缺点每次调用都会创建一个实例
  
  // 此处是无参构造函数 创建对象无需传参数
  // 实例化时 需要 new 对象
  DioUtils() {
    // 构造函数体，对象创建完成之后才执行这里的代码
    // 做基本的操作
    // 配置基础地址 所有相对路径的请求都会拼在这个地址后面
    _dio.options.baseUrl = "https://geek.itheima.net/v1_0/";
    // 链接超时 发起请求到连接的等待时间
    _dio.options.connectTimeout = Duration(seconds: 10);
    //发送超时
    _dio.options.sendTimeout = Duration(seconds: 10);
    //接收超时
    _dio.options.receiveTimeout = Duration(seconds: 10);
    // followRedirects‌：是否允许重定向，配合 maxRedirects 设置最大重定向次数
    _dio.options.followRedirects = true;
    _dio.options.maxRedirects = 100;

    // 拦截器
    _addInterceptor(); // 注册添加拦截器
  }

  // dio5 的 `Interceptor` 是重写 `@override` 方法，不是直接传匿名函数（很多人踩坑）
  // 推荐两种写法：继承 `Interceptor` 类，或者用 `InterceptorsWrapper`
  // 不是直接写 Interceptor  直接写是报错的
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截
        onRequest: (context, handler) {
          handler.next(context);
        },
        // 响应拦截器
        onResponse: (context, handler) {
          if (context.statusCode! >= 200 && context.statusCode! < 300) {
            handler.next(context);
            return;
          }
          // 说明出现异常
          handler.reject(DioException(requestOptions: context.requestOptions));
        },
        // 说明出异常
        //  错误拦截（网络错误、超时、上面reject过来的错误都会进这里）
        onError: (context, handler) {
          handler.next(context);
        },
      ),
    );
  }

  // 向外提供get方法
  get(String url, {Map<String, dynamic>? params}){
    // 发送get请求 自己拼装
    return _dio.get(url, queryParameters: params);
  }
}
