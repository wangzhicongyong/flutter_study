// 用户与应用程序交互时触发的各种动作 滑动 点击  触摸屏幕
// 点击事件  当点击某个元素触发的动作
// gestureDetector 是flutter中最常用，功能醉丰富的手势检测组件
// 使用gesttureDetector 包裹被点击的元素，传入onTab方法

// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: "hello world",
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.blue
    ),
    // 窗口主体
    home: Scaffold(
      appBar: AppBar(
        title: Text("头部区域"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          // 添加点击事件
          child:GestureDetector(
            onTap: () {  // 传入onTab方法
              print("点击了该区域");
            },
            child: Text("中间区域"),
          )
        ),
      ),
      // 自己的扩展
      bottomNavigationBar: Container( // 容器是可以设置高度的
        height: 80,
        color: Colors.white,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const[
            // mainAxisSize:MainAxisSize.min 设置 多打的内容 占多大
            Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.home), Text("首页")],),
            Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.person), Text("我的")],)
          ],
          // child: Text("底部区域"),
        )
      ),
      ),
    ),
  );
}