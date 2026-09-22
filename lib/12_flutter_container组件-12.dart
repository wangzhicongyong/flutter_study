import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // 骨架的背景颜色
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            width: 280,
            height: 180,
            // 这个设置的 已经没有效果
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(16),
            alignment: Alignment.topLeft,
            // container 的装饰器
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              // 阴影
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10)
              ],
            ),
            child: Text("Container演示", style: TextStyle(fontSize:18)),
          ),
        ),
      ),
    );
  }
}