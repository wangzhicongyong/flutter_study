
// go_router 是 Flutter 官方维护的**基于 Navigator2.0**的声明式路由
// URL 驱动，支持 deeplink、路由重定向、嵌套路由、多 Tab 独立页面栈，适合中大型 App、Web、桌面端


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// - 匹配路径`/`，找到顶层 `GoRoute(path:'/')`
// - 执行它的 `builder: (context, state) => const HomePage()`
// - 生成 HomePage，交给 routerDelegate 放到导航栈，渲染到屏幕。


final _rootKey = GlobalKey<NavigatorState>();

// GoRouter：全局单例，App 启动创建，全程存活
final GoRouter router = GoRouter(
  navigatorKey: _rootKey,
  // 初始化页面
  initialLocation: '/',
  debugLogDiagnostics: true,
  // 错误404页面
  errorBuilder: (ctx, state) => const Scaffold(body: Center(child: Text("404页面不存在"))),
  // 路由树列表
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
      // 嵌套路由
      routes: [
        // 详情页
        GoRoute(
          path: 'detail/:id',  // 相对路劲
          name: 'detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final extra = state.extra as String?;
            // extra 额外信息 数据
            return DetailPage(id: id, extra: extra);
          },
        ),
      ],
    ),
    GoRoute(path: '/login', name: 'login', builder: (c,s)=>LoginPage()),
  ],
);

void main() {
  // Flutter Web 默认是 **hash 模式**：地址是 `localhost/#/detail/123`
  // 开启history模式，去掉地址栏 #
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  ==== `router` 是顶部预先定义好的**全局 GoRouter 实例**，在 main 执行前就已经完成对象构造：
  //  三个对象被取出，交给`MaterialApp.router`，接管 Navigator2.0 路由系统
  //  此时 Flutter 不再使用旧的命令式 Navigator，全部路由交给 go_router 控制
  @override
  Widget build(BuildContext context) {
    // 挂载到 App：**必须用 `MaterialApp.router`**
    return MaterialApp.router(
      // routerDelegate —— 路由代理【负责页面栈管理】
      // 管理 **Navigator 页面栈**，决定当前屏幕要渲染哪个页面、管理 push/pop、页面销毁重建、监听导航栈变化
      routerDelegate: router.routerDelegate,
      // routeInformationParser —— 路由信息解析器【字符串 ↔ 路由状态】
      // 把浏览器地址栏的 URL 字符串（RouteInformation）解析成 go_router 认识的路由状态对象；反过来也能把路由状态序列化成 URL。
      routeInformationParser: router.routeInformationParser,
      // 路由信息提供者【监听外部 URL 变化】
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

// 主页
class HomePage extends StatelessWidget{

  const HomePage({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            // 命名路由跳转到详情页
            ctx.goNamed(
              'detail',
              pathParameters: {'id':'1001'},
              extra: '额外信息',
            );
          },
          child: const Text("打开详情"),
        ),
      ),
    );
  }
}

// 详情页
class DetailPage extends StatelessWidget{
  final String id;
  final String? extra;
  const DetailPage({super.key, required this.id, this.extra});

  @override
  Widget build(ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页 $id"),
        centerTitle: true,
        ),
      body: Center(child: Text("extra: $extra")),
    );
  }
}

// 登录页
class LoginPage extends StatelessWidget{

  const LoginPage({super.key});

  @override
  Widget build(ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页"),
        centerTitle: true,
        ),
      body: Center(child: Text("无")),
    );
  }
}
