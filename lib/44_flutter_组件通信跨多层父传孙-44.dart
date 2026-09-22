
// InheritedWidget：跨多层组件传值（不用逐层透传）
// 适用场景：祖孙多层组件，中间有多层嵌套，不想一层一层传参（避免 props drilling）
// 底层是 Provider、Riverpod 等状态管理的基础，只有依赖这个数据的子组件才会重建，性能好

import 'package:flutter/material.dart';

void main() => runApp(const Parent());

// 1. 自定义InheritedWidget，存放共享数据  跨多层组件共享数据
class MyInherited extends InheritedWidget {  // 属于底层基建 widget
  // 共享数据
  final String shareData;
  const MyInherited({super.key, required super.child, required this.shareData});

  // 返回true：数据变化时通知依赖它的子组件重建
  // InheritedWidget：`updateShouldNotify` 返回 true 才会通知依赖组件；`dependOnInheritedWidgetOfExactType` 注册依赖
  // 1.return true**：新旧数据不一样 → 通知所有**注册过依赖**的子 Element（调用过 `context.dependOnInheritedWidgetOfExactType`），触发子组件 `didChangeDependencies` + `build` 重建CSDN博...
  // 2.return false**：数据没变 → **不通知依赖子组件**，子组件不会重建，性能优化的核心点
  // 3.注意：只是不通知依赖子组件，InheritedWidget 自身还是会被重建
  // 是 Flutter 跨组件共享状态的核心钩子Flutter
  @override
  bool updateShouldNotify(covariant MyInherited oldWidget) {
    // 判断数据是否更新 旧widget实例
    return shareData != oldWidget.shareData;
  }

  // 子组件获取数据的静态方法
  // **return true**：新旧数据不一样 → 通知所有**注册过依赖**的子 Element（调用过 `context.dependOnInheritedWidgetOfExactType`）
  // 在子组件里向上查找最近的 `MyInherited`，并且**注册依赖**，搭配前面的 `updateShouldNotify` 一起工作Flutter
  // 向上查找 注册依赖
  static MyInherited? of(BuildContext ctx) {  // **注册依赖**：当前这个 ctx 对应的组件会被记录为依赖方
    return ctx.dependOnInheritedWidgetOfExactType<MyInherited>();
  }
}

// 父组件
class Parent extends StatefulWidget {

  const Parent({super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {

  String data = "我是祖先组件数据";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // 此处也是组件
        body: MyInherited(
          // 共享数据
          shareData: data,
          child: Column(
            children: [
              // 按钮
              ElevatedButton(
                onPressed: ()=>setState(()=>data="更新后"),
                 child: const Text("修改")),
              // 中间随便嵌套多层，孙组件依然可以拿到数据
              MiddleWidget()
            ],
          ),
        ),
      ),
    );
  }
}

// 无状态组件
class MiddleWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 孙组件
    return GrandChild();
  }
}

// 孙组件，直接获取上层Inherited数据
class GrandChild extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final inherited = MyInherited.of(context);

    return Text("孙组件拿到：${inherited?.shareData}");
  }
}