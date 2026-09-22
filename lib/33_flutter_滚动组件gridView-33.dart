// 用于创建二维可滚动网格布局的核心组件
// 二维可滚动网格组件，用来做商品列表、相册、九宫格、图标墙，和 `ListView` 同源，**支持懒加载**
// 使用GridView.builder构造实现动态长网格（懒加载，只渲染可见区域）

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("GridView代码示例"),
        ),
        // 大数据列表推荐
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          // 布局委托 按照列数去固定
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // 使用 mainAxisExtent 固定 item 高度（推荐，不用算比例）
            // Item 格子**固定高度 60
            mainAxisExtent: 100,  // 设置item的高度
            maxCrossAxisExtent: 200,
            // 列与列之间的距离
            crossAxisSpacing: 10,
            mainAxisSpacing: 10, //行与行之间的间距
            // 不用 mainAxisExtent，靠 childAspectRatio 比例控制高度
            // childAspectRatio: 1, // 宽高比 就会失去效果
          ),
          itemCount: 100,
          // 构建函数 构建每一个item  根据itemCount 来确定构建多少项
          itemBuilder: (BuildContext context, int index) {
            // 不要在item的Container写height！gridDelegate 接管尺寸，你写 height 会被忽略
            return Container(
              // margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              // width: double.infinity,
              color: Colors.blue,
              // height: 100,
              child: Text(
                "我是第${index + 1}个",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }),
      ),
    );
  }
}
