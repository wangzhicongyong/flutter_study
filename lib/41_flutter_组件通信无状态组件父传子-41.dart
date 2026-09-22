// ========================================父传子 构造函数传参数
// ========================================1.子组件定义接收属性
// ========================================2.子组件在构造函数中接收参数
// ========================================3.父组件传递属性给子组件
// ========================================核心：父组件传子组件是  组件之间的嵌套传递数据  不是根本的继承关系
// ========================================父组件和子组件，关系就是套娃的关系
// 父传子（数据下发）‌：父组件通过构造函数把数据传给子组件即可，子组件是无状态组件时用 final 接收；
// 子组件是有状态组件时，在 initState 或 didUpdateWidget 中接收。这种方式父组件通常是有状态组件，子组件是否有状态不影响传值本身。
// ‌子传父（回调通知）‌：父组件把回调函数传给子组件，子组件在事件触发时调用该回调。典型场景是“点击子组件，修改父组件状态”——此时父组件必须是有状态组件才能 setState 刷新，子组件可以是有状态也可以是无状态。
// ‌兄弟通信（状态提升）‌：两个兄弟组件需要同步时，把共享状态提升到共同的父组件管理，父组件再通过“父传子”下发给两个子组件。这要求父组件是有状态组件
// ‌跨层级通信‌：当层级较深、逐层传递麻烦时，可以用 GlobalKey 直接访问子组件的 State 对象来调用其方法，或者用 InheritedWidget 实现跨组件数据共享

// 无状态组件‌：只负责展示，数据全部由外部传入,自身不保存可变状态，无法用 setState 刷新自己.如果子组件是纯展示的，保持无状态是更轻量的做法。
// ‌有状态组件‌：自己保存状态、能响应交互并刷新 UI.需要管理内部状态时，才把它做成有状态组件


import 'package:flutter/material.dart';

void main() {
  // myapp（）是widget对象
  runApp(const MainPage());
}

// ====================== 1.无状态组件：父是无状态组件，子也是无状态组件=========================
// StatelessWidget 是无状态组件 没有state对象  没有setState（）方法 所有属性必须是 final, UI 完全靠构造函数传入参数决定
class MainPage extends StatelessWidget {
  // const 开启常量性能优化 如果组件参数不变，复用同一个对象实例；父组件重建时，该Widget不会重复创建，优化性能
  // const MyApp(Key? key):super(key:key)  Widget 基类需要`key`，用于在 组件树 识别组件节点，做 diff 更新、状态保留
  // const MyApp({super.key});
  const MainPage({Key? key}) : super(key: key);

  // build 只写 UI 组装代码，不要写业务逻辑、网络请求、定时器、弹窗
  // 重写build方法，返回一个组件对象  build 方法会反复执行
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
              // 父组件传子组件：意思是在父组件里面定义的参数，给了子组件的构造函数(子组件里面声明了 字段)，然后在子组件里面显示出来，这就是父传子，不是其它编程语言的那种 通信管道
              // 切记别搞混淆
              Child(message: "张三"),
            ],
          ),
        ),
      ),
    );
  }
}

class Child extends StatelessWidget {
  // 必须使用final 关键字定义
  final String? message;
  // 在构造函数接收参数
  // Child({super.key, required this.message});
  const Child({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 无状态子组件 不能使用 widget.message 来获取数据
    return Container(
      child: Text(
        "子组件接收-$message",
        style: TextStyle(color: Colors.red, fontSize: 30),
      ),
    );
  }
}
