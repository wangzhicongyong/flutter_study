
// 1.父组件传递一个函数给子组件
// 2.子组件调用该函数
// 3.父组件通过回调函数获取参数

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // myapp（）是widget对象
  runApp(const MainPage());
}


//**********父是有状态组件
//**********子是有状态组件
//**********用回调,无状态子组件无法自己 setState，通过回调把事件抛给父Stateful，由父更新状态 */
class MainPage extends StatefulWidget {
 
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
  // 重写build方法，返回一个组件对象 build 方法会反复执行  主要是组件的更新重建
  @override
  Widget build(BuildContext context) {
    // **MaterialApp**：**根**，全局，管主题、路由,整个 APP 只写一次
    return MaterialApp(
      title: '组件通信-子传父演示', // 任务窗口主题 浏览器打开的页面标签
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
            return Child(
              foodName: _list[index],
              index: index,
              // 此处定义业务删除函数 子组件触发该回调函数
              delFood: (int i) {
                _list.removeAt(i);
                // 监听状态，触发build刷新重建
                // **通知Flutter框架状态发生变化，触发当前State的 build () 重新执行，刷新 UI**Flutter
                setState(() {
                });
              },
            );
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

  // 菜单索引
  final int index;

  // 子类必须定义业务函数
  final Function(int index) delFood;  // 声明一个带参数的函数

  // 在构造函数接收参数
  // Child({super.key, required this.message});
  const Child({
    Key? key,
    this.foodName,
    required this.index,
    required this.delFood,
  }) : super(key: key);

  @override
  State<Child> createState() {
    return _ChildState();
  }
}

// 对内的类==========2.通过widget来获取定义的属性========================
class _ChildState extends State<Child> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.topRight, // 跟使用positined效果一样
      children: [
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "${widget.foodName}", // widget 实际上就是 Child页面
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        // 删除图标
        Positioned(
          // right: 10,
          child: IconButton(
            onPressed: () {
              widget.delFood(widget.index);  // 点击图标 调用 回调函数
            },
            color: Colors.red,
            icon: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
