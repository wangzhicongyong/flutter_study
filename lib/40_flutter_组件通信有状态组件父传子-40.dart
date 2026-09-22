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

class MainPage extends StatefulWidget {
  // const 开启常量性能优化 如果组件参数不变，复用同一个对象实例；父组件重建时，该Widget不会重复创建，优化性能
  // MyApp的构造函数 简写
  // const MyApp(Key? key):super(key:key)  Widget 基类需要`key`，用于在 组件树 识别组件节点，做 diff 更新、状态保留
  // const MyApp({super.key});
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  // build 只写 UI 组装代码，不要写业务逻辑、网络请求、定时器、弹窗
  // 重写build方法，返回一个组件对象
  // build 方法会反复执行
  @override
  Widget build(BuildContext context) {
    // **MaterialApp**：**根**，全局，管主题、路由,整个 APP 只写一次
    return MaterialApp(
      title: '组件通信-父传子演示', // 任务窗口主题 浏览器打开的页面标签
      // 关闭右上角debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.red.shade200)),
      themeMode: ThemeMode.system, // system跟随系统 light浅色 dark深色
      // 指定主页 默认首页
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("父组件", style: TextStyle(color: Colors.blue, fontSize: 30)),
              // 父组件传子组件：意思是在父组件里面定义的参数，给了子组件的构造函数，然后在子组件里面显示出来，这就是父传子，不是其它编程语言的那种 通信管道
              // 切记别搞混淆
              Child(message: "张三"),
            ],
          ),
        ),
      ),
    );
  }
}


// ==============有状态组件1.对外的类定义属性===========================
class Child extends StatefulWidget {
  // 必须使用final 关键字定义
  final String? message;

  // 在构造函数接收参数
  // Child({super.key, required this.message});
  const Child({Key? key, this.message}) : super(key: key);

  @override
  State<Child> createState() {
    return _ChildState();
  }
}

// 对内的类==========2.通过widget来获取定义的属性============================
class _ChildState extends State<Child> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "子组件接收-${widget.message}",  // widget 实际上就是 Child页面
        style: TextStyle(color: Colors.red, fontSize: 30),
      ),
    );
  }
}
