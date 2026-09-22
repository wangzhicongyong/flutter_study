// 用于创建二维可滚动网格布局的核心组件
// 二维可滚动网格组件，用来做商品列表、相册、九宫格、图标墙，和 `ListView` 同源，**支持懒加载**

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("GridView代码示例"),
        ),
        // count /extent 默认构造**不会懒加载**，数据量大直接卡顿，超过 50 条务必用 `GridView.builder`
        // 比较常用
        // 主要是基于固定列数的网格布局
        body: GridView.count(
          // 滚动方向是默认向下
          // scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          // 设置固定的列数
          crossAxisCount: 5,
          // 行与行之间的间距
          mainAxisSpacing: 10,
          // 列与列之间的间距
          crossAxisSpacing: 10,
          children: List.generate(100, (index) {
                    return Container(
                      // margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      // width: double.infinity,
                      color: Colors.blue,
                      // height: 100,
                      child: Text("我是第${index+1}个", 
                      style: TextStyle(color: Colors.white, fontSize: 20)),
            );
          }),
        )
      ),
    );
  }

  validator(value) {
    if (value == null || value.isEmpty) return "密码不能为空";
    return null;
  }
}
