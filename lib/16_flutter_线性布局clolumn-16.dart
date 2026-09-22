// column是垂直方向排列子widget的布局组件，属于flex的子类，一行多列用row,一列多行用column
// 主抽是垂直方向  交叉轴是 水平方向
// `Expanded(child:xxx)` = `Flexible(flex:1,fit:FlexFit.tight)`：强制占满分配的空间
// `Expanded` 只能放在 `Column、Row、Flex` 的 children 里面使用，放别的组件直接报错。
// Column 默认 `mainAxisSize: MainAxisSize.max`，占满屏幕高度 是默认的

// column高度是由父组件决定，直接沾满父组件给的全部垂直空间

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
          centerTitle: true, // 导航标题居中
          title: Text("padding代码示例"),
        ),
        // align
        // container的宽高 是 align 的宽高  沾满父组件
        body: Container(
          // 设置宽高  正无穷大
          width: double.infinity, 
          height: double.infinity,
          // padding: EdgeInsets.all(20),  // 在container直接用padding也是可以的
          decoration: BoxDecoration(color: Colors.amber),
          // 哪怕3个container的高度是300，column也会沾满父组件
          // x需要设置根据子组件来控制  默认是 MainAxisSize.max
          child: Column(  // 没有宽高属性 根据子控件来控制
          // 设置子组件的对齐方式
          // 如果是在子组件里面设置了margin 则父组件设置的约束就会取消，优先使用自己的
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisAlignment: MainAxisAlignment.start, 
          // 设置这个 column的高度就根据儿子来决定 
          mainAxisSize: MainAxisSize.min,   
            children: [
              Container(
                // 可以设置子组件之间的距离
                // margin: EdgeInsets.only(top: 10),
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              Container(
                // margin: EdgeInsets.only(top: 100),
                width: 100,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.cyanAccent
              ),
            ],
          ),
        ),
      ),
    );
  }
}