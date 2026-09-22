// 作用：层叠布局，允许将多个子组件按照深度方向进行叠加排列
// positioned组件是stack的黄金搭档，对子组件进行精确定位控制
// stack本身沾满父容器空间，子组件分两种，无定位子组件，positioned定位子组件
// `Positioned` 的子组件不受 alignment 控制，哪怕 Stack 有尺寸，Positioned 也不理 alignment

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @protected
  List<Widget> getList() {
    // Dart 会隐式返回`null`  必须是返回 widget
    return List.generate(10, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("Text代码示例"),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber,
          child: Text(
            "今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，今天天气非常不错，",
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
              height: 5
            ),
            maxLines: 2,
          )
        ),
      ),
    );
  }
}
