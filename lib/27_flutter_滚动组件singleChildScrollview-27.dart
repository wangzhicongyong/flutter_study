// 包裹一个子组件，让组件具备滚动功能，所有内容是一次性渲染
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
    return List.generate(100, (index) {
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
        body: SingleChildScrollView(
          child: Column(
                  children: List.generate(100, (index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      color: Colors.blue,
                      height: 100,
                      child: Text("我是第${index+1}个", style: TextStyle(color: Colors.white),),
            );
          }),
        )),
      ),
    );
  }

  validator(value) {
    if (value == null || value.isEmpty) return "密码不能为空";
    return null;
  }
}
