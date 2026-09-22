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
          title: Text("Stack代码示例"),
        ),
        // align
        // container的宽高 是 align 的宽高  沾满父组件
        // 外层套 `SizedBox / Container` 给 Stack 固定宽高
        // Stack 的尺寸由「非定位子组件」决定；如果没有非定位子组件，Stack 自身宽高 = 0×0  自己是没有宽高的
        body: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(16)
          ),
          // 尽可能沾满父组件
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.grey,
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 100,
                height: 100,
                color: Colors.red,
                ) ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                ) ),
            ],

          ),
        )
      ),
    );
  }
}
