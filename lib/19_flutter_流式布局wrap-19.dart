// 作用：流式布局组件，当子组件在主轴方向上排列不下时，它会自动换行或换列
// 当子组件内容是根据数据动态生成时，可以使布局始终适配
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @protected
  List<Widget> getList() {  // Dart 会隐式返回`null`  必须是返回 widget
     return List.generate(10, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("wrap代码示例"),
        ),
        // align
        // container的宽高 是 align 的宽高  沾满父组件
        body: Container(
          // 设置宽高  正无穷大
          width: double.infinity,
          height: double.infinity,
          // padding: EdgeInsets.all(20),  // 在container直接用padding也是可以的
          decoration: BoxDecoration(color: Colors.tealAccent),
          // flex也是默认最大沾满父组件空间
          child: Wrap(
            // 水平方向 子组件的间距
            spacing: 10,
            // 垂直方向 子组件的间距
            runSpacing: 10,
            // 此参数是必传
            direction: Axis.horizontal, // 决定子组件的排列方向
            children: getList(),
          ),
        ),
      ),
    );
  }
}
