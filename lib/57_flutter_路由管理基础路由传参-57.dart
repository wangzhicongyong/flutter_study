// 基础路由传参
// 传递参数 通过组件构造函数传递参数（父传子）
// 接收参数 通过组件构造函数接收参数（父传子）
// 接收时机 initState可获取到基础路由的构造函数传参

// 路由管理是构建多页面应用的核心，它通过navigator和route来管理页面栈，实现页面跳转和返回
// 基本路由是适合页面不多，跳转逻辑简单的场景
// 用法：无需提前注册路由，跳转时创建MaterialPagRoute实例即可

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
      home: ListPage(), // 列表页  详情页
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
            onTap: () async {
              // 点击 执行路由操作 入栈  打开新页面
              // `Navigator.push` 返回一个Future`，**当详情页执行 `Navigator.pop(上下文, 参数)` 完成后，这个 Future 才会 resolve，result 拿到值
              final result = await Navigator.push(
                context,
                // 组件路由 路由指定页面
                // 父传子 构造函数传参  在父组件构建子组件的构造函数，传参
                MaterialPageRoute(
                  requestFocus: true,
                  builder: (context) {
                    return DetailPage(id: index);
                  },
                ),
              );
              // 组件挂载完成 渲染完
              if (mounted) {
                print("返回的数据：$result");
              }
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
  // 必须是final 声明参数
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailPage> {
  @override
  void ininState() {
    super.initState();
    print(widget.id);
  }

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
        child: TextButton.icon(
          style: TextButton.styleFrom(
            fixedSize: Size(160, 80),
            // 文字颜色
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: Text("返回上一页${widget.id}", style: TextStyle(color: Colors.blue)),
          ),
        ),
      ),
    );
  }
}
