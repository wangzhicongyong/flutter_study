// 实现文本输入功能的核心组件

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return _Homepage();
  }

  @protected
  List<Widget> getList() {
    // Dart 会隐式返回`null`  必须是返回 widget
    return List.generate(10, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }
}

class _Homepage extends State<Homepage> {

  // 定义文本控制器

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("textfield代码示例"),
        ),
        body: Container(
          // 内部与子组件的间距，外边框
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          // 设置背景颜色
          color: Colors.white,
          child: Column(
            children: [
              TextField(), TextField(),
            ],
          ),
        ),
      ),
    );
  }

  validator (value) {
    if(value == null || value.isEmpty) return "密码不能为空";
    return null;
  }
}


