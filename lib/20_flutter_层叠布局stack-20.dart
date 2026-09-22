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
  List<Widget> getList() {  // Dart 会隐式返回`null`  必须是返回 widget
     return List.generate(10, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("Stack代码示例"),
        ),
        // align
        // container的宽高 是 align 的宽高  沾满父组件
        // 外层套 `SizedBox / Container` 给 Stack 固定宽高
        // Stack 的尺寸由「非定位子组件」决定；如果没有非定位子组件，Stack 自身宽高 = 0×0  自己是没有宽高的
        
        body: Stack(
          // `StackFit.expand` 的含义：**把所有【非 Positioned 包裹】的子组件，强制拉伸到和 Stack 一样大**
          // fit: StackFit.expand,  // 设置fit 则让stack占满父组件
          // 只对子组件有约束  针对所有的子组件 并且是没有被 positioned包裹的组件
          alignment: Alignment.center,
          // 子组件列表，顺序决定堆叠层级：列表越靠后，层级越高，盖在最上面
          // alignment 只作用于【没有被 Positioned 包裹】的子组件
          // stack布局本身是没有空间大小的，存在非 Positioned 子组件时，**Stack 的尺寸 = 这个非定位子组件的尺寸**
          // 目前这个stack是400*400 跟子组件是一样大的，所以居中效果是看不到的
          children:[
            // 看不见的占位，让 Stack 占满父容器的可用空间
            const SizedBox.expand(),
            Container(
              width: 400,
              height: 400,
              color: Colors.amber,
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.deepPurpleAccent,
            )
          ] 
        )
      ),
    );
  }
}
