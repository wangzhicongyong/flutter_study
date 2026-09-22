import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,   // 导航标题居中
          title: Text("center代码示例"),
        ),
        // center组件不能设置宽高,但会尽可能的去占有父组件的空间大小,受父组件的约束
        // 实现固定宽高且居中的组件
        body: Center(
          child: Container(
            // 文字居中
              alignment: Alignment.center,
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Text("居中内容"),
          ),
        ),
      ),
    );
  }
}
