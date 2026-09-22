
// **Scaffold** 是 Material 组件库的页面脚手架，**每个 Material 页面几乎都要用它**
// 帮你快速划分页面各个区域：顶部 AppBar、主体 body、悬浮按钮、底部导航、侧边抽屉等Flutter
// Scaffold = 页面的容器骨架。必须放在 `MaterialApp` 里面才能正常工作
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: "hello world",
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.blue
    ),
    // 窗口主体
    home: Scaffold(
      appBar: AppBar(  // 顶部标题栏
        title: Text("头部区域"),
        centerTitle: true,
      ),
      // 页面主体 核心内容区
      body: Container(
        child: Center(
          child: Text("中间区域"),
        ),
      ),
      // 右下角的悬浮按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      // **必须放在 Scaffold 里面**，单独写 Drawer 不会自动弹出、没有汉堡按钮
      // `const Drawer()`：不加 child，就是空白抽屉面板
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // 抽屉头部  
            const DrawerHeader(
              margin: EdgeInsets.all(120),
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(

                child: Text("菜单头部")),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("首页"),
              onTap: () {
                // Navigator.pop(context); // 点击关闭抽屉
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("设置"),
              // onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ), // 左侧侧边抽屉
       // 右下角悬浮按钮
      // 自己的扩展  // 底部的导航栏
      bottomNavigationBar: Container( // 容器是可以设置高度的
        height: 80,
        color: Colors.white,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const[
            // mainAxisSize:MainAxisSize.min 设置 多打的内容 占多大
            Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.home), Text("首页")],),
            Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.person), Text("我的")],)
          ],
          // child: Text("底部区域"),
        )
      ),
      ),
    ),
  );
}