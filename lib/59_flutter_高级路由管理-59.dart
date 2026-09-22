import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "onGenerateRoute Demo",
      initialRoute: '/',
      // 核心：路由生成
      // onGenerateRoute：返回路由**前可以写逻辑**（登录判断、动态参数解析、根据条件返回不同页面）
      onGenerateRoute: (RouteSettings settings) {
        // 路由名称
        final String? routeName = settings.name;
        // 路由参数
        final args = settings.arguments;
        switch (routeName) {
          case '/':
            return MaterialPageRoute(
              builder: (ctx) => const HomePage(),
              settings: settings,
            );
          case '/detail':
            // 取路由参数
            final int id = args as int;
            // 基础路由传参  构造函数
            return MaterialPageRoute(
              builder: (ctx) => DetailPage(id: id),
              settings: settings,
            );
          default:
            // 匹配不到交给onUnknownRoute
            return null;
        }
      },
      // 如果找不到匹配的路由 就直接跳转到 404页面
      onUnknownRoute: (settings) {
        // 404兜底页面
        return MaterialPageRoute(builder: (ctx) => const NotFoundPage());
      },
    );
  }
}

// 页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("首页")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 命名路由跳转，携带参数
            Navigator.pushNamed(context, '/detail', arguments: 1001);
          },
          child: const Text("打开详情页"),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("详情 $id")));
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("404 页面不存在")));
  }
}
