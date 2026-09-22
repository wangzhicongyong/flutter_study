// Flutter 网络方案有 3 种：**dart:io HttpClient（底层，不推荐业务直接用）、官方 http 包（轻量）、Dio 5.x（企业项目首选，当前最新稳定版）**Pub
// ## Dio 5.x（主流项目推荐，重点）
// ### 核心特性
// - 全局基础地址、全局请求头、超时配置
// - **拦截器 Interceptor**：统一加 token、日志打印、401 自动刷新 token
// - 内置 FormData 文件上传、下载进度监听
// - 请求取消 CancelToken
// - 完善异常 `DioException` 分类：连接超时、接收超时、4xx/5xx 响应、网络异常等CSDN博...
// ### 1. 全局单例 Dio（最佳实践，不要每次 new Dio）
// 安裝 flutter pub add dio
// 基本使用：Dio().get(地址).then().catchError()

import 'package:dio/dio.dart';

void main(List<String> args) {
  Dio()
      .get("https://geek.itheima.net/v1_0/channels")
      .then((res) {
        print(res);
      })
      .catchError((error) {});
}
