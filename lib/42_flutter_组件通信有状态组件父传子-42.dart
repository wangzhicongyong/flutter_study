// 父传子 构造函数传参数
// 1.子组件定义接收属性
// 2.子组件在构造函数中接收参数
// 3.父组件传递属性给子组件
// 4.有状态组件在对外的类接收属性 对内的类通过widget对象获取对应属性
// 5.原理：Widget 是不可变对象，子组件在构造器定义 `final` 参数，父组件在实例化子组件时传入数据；
// 父调用 `setState` 更新数据，子组件会重建拿到最新参数。
// 核心：父组件传子组件是  组件之间的嵌套传递数据  不是根本的继承关系

import 'package:flutter/material.dart';

// title 用来展示窗口的标题内容
// theme 用来设置整个应用的主题
// home 用来展示窗口的主体内容

void main() {
  // myapp（）是widget对象
  runApp(const MainPage());
}

// StatelessWidget 是无状态组件 没有state对象  没有setState（）方法 所有属性必须是 final, UI 完全靠构造函数传入参数决定
class MainPage extends StatefulWidget {
  // const 开启常量性能优化 如果组件参数不变，复用同一个对象实例；父组件重建时，该Widget不会重复创建，优化性能
  // MyApp的构造函数 简写
  // const MyApp(Key? key):super(key:key)  Widget 基类需要`key`，用于在 组件树 识别组件节点，做 diff 更新、状态保留
  // const MyApp({super.key});
  const MainPage({super.key});

  @override
  State<MainPage> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  // 菜单
  List<String> _list = [
    "鱼香肉丝",
    "宫爆鸡丁",
    "油淋茄子",
    "肉沫茄子",
    "红烧鱼块",
    "鱼头泡饭",
    "红烧黄瓜",
    "小炒青菜",
  ];
  // build 只，写 UI 组装代码，不要写业务逻辑、网络请求、定时器、弹窗
  // 重写build方法，返回一个组件对象
  // build 方法会反复执行  主要是组件的更新重建
  @override
  Widget build(BuildContext context) {
    // Theme.of(context).colorScheme.primary;
    // **MaterialApp**：**根**，全局，管主题、路由,整个 APP 只写一次
    return MaterialApp(
      title: '组件通信-父传子演示', // 任务窗口主题 浏览器打开的页面标签
      // 关闭右上角debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.red.shade200)),
      themeMode: ThemeMode.system, // system跟随系统 light浅色 dark深色
      // 指定主页 默认首页
      home: Scaffold(
        body: GridView.count(
          // 列数
          crossAxisCount: 2,
          // index 默认是从0开始
          children: List.generate(_list.length, (int index) {
            return Child(foodName: _list[index]);
          }),
        ),
      ),
    );
  }
}

// ==============有状态组件1.对外的类定义属性===========================
class Child extends StatefulWidget {
  // 必须使用final 关键字定义
  final String? foodName;

  // 在构造函数接收参数
  // Child({super.key, required this.message});
  const Child({Key? key, this.foodName}) : super(key: key);

  @override
  State<Child> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

// 对内的类==========2.通过widget来获取定义的属性============================
class _ChildState extends State<Child> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        "${widget.foodName}", // widget 实际上就是 Child页面
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
