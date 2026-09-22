// 用法：需提前注册路由，注册一个路由表，并设置initialRoute

// **新项目优先 go_router**，它是 Flutter 官方推荐的基于 Navigator2.0 的声明式路由包
// 完美支持Web、DeepLink、路由守卫、嵌套路由、底部Tab保状态;小型简单页面可继续使用原生Navigator1.0

// 目前路由体系  主要都是维护一个 页面栈

import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 路由**拦截器**，优先级高于 routes，适合动态路由、参数解析、权限判断
      // onGenerateRoute: ,
      // App 启动默认打开的路由名称
      initialRoute: "/list",
      // home: ListPage(), // 列表页  详情页
      // 注册路由表
      routes: {
        // 根据路由 构建组件
        "/list": (context) => ListPage(),
        "/detail": (context) => DetailPage(),
      },
    );
  }
}

// 列表页
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 关闭flutte框架自带的返回上一页按钮
        automaticallyImplyLeading: false,
        title: Text("列表页"),
        // 标题居中
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 50,
        // item最大高度 可以打开 `itemExtent:60`，比在 Container 写 height 性能更好
        itemExtent: 60,
        itemBuilder: (BuildContext context, int index) {
          // 给每个item增加点击的效果
          return GestureDetector(
            onTap: () {
              // 此方法是替换当前页，新页面入栈 ----旧页面出栈
              // =============可以运行测试，点击退回上一页是 没有的==============================
              Navigator.pushNamed(context, "/detail", arguments: {"id": index});
            },
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              // 最好是不要在item里设置高度
              // height: double.infinity,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                "列表$index",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 详情页
class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailPage> {
  String _id = " ";

  // `initState` 同步代码中 `ModalRoute.of(context)` 经常返回 `null`
  // 具体的原因是：build 执行时 context 路由已经挂载完成
  @override
  void initState() {
    super.initState();
    // // 获取路由参数，跳转详情页，需要数据渲染 初始化时获取最好
    // // 当然也是可以在页面上获取的
    // 在微任务获取到数据
    Future.microtask(() {
      final route = ModalRoute.of(context);
      // 判断路由对象是否存在
      if (route != null) {
        // 能够获取路由参数
        final args = route.settings.arguments;
        if (args is Map<String, dynamic>) {
          print(args["id"]);
          _id = args["id"].toString();
          setState(() { 
          });
        } else {
          debugPrint("参数不是Map或者为空");
          }
      }
    });
  }

  // build 执行时 context 路由已经挂载完成 
  // 因为context已经完成，所以百分之百 ModalRoute.of(context)肯定不是返回null
  // 所以基本是在build店里面获取数据
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
        // 标题居中
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        // `TextButton` 本身设计就是**无背景无边框文字按钮**
        // 没有宽高约束，沾满父组件空间
        // SizedBox 包裹按钮（最常用，可读性好）
        alignment: Alignment.center,
        // 带图标的构造函数
        child: Column(
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                // 控制按钮大小
                fixedSize: Size(120, 40),
                // 文字颜色
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // 强行加边框
                side: const BorderSide(
                  color: Colors.red,
                  width: 2,
                  style: BorderStyle.solid,
                ), // 增加边框
              ),
              onPressed: () {
                // 这里是可以进行传参数的
                Navigator.pop(context, "来自详情页的数据");
              },
              icon: const Icon(Icons.arrow_back), // 图标,
              // widget
              label: FittedBox(
                // 文字自适应大小
                fit: BoxFit.scaleDown, // 文字太长才缩小；文字短就保持原生大小，**不会强行放大文字**（最常用）
                child: Text("去列表页$_id", style: TextStyle(color: Colors.blue)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("返回上一页"),
            ),
          ],
        ),
      ),
    );
  }
}
