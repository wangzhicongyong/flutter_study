import 'package:flutter/material.dart';

void main(List<String> args) {
  // 当组件被创建火父组件状态变化导致其需要重新构建时
  runApp(MyWidget());
}

// 无状态组件
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("头部区域"), centerTitle: true),
        body: Container(child:Center(child: Text("无状态组件"),) ,),
      ),
    );
  }
}
