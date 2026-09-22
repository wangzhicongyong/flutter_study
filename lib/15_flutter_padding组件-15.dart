// align 精确控制其子组件在父容器空间内的对齐位置
// alignment(对齐方式):子组件在父容器内的对齐方式
// widthFactor（宽度因子）：align的宽度将是子组件宽度乘以因子
// heighFactor (高度因子):align的高度将是子组件高度乘以该因子
// `Align` 是**单孩子对齐组件**，用来控制子组件 `child` 在 Align 自身盒子内的摆放位置
// align自身就是一个盒子
// `Center` 本质就是 `Align(alignment: Alignment.center)`
// 1. Align 先确定自己的盒子大小  首先自己就是一个盒子  然后再来做 子组件的相对位置
// 2. 在自己盒子范围内，把 child 放到指定对齐位置
// 在 Column / Row 里面 Align 对齐不生效
// 需要外层包 Expanded，给 Align 分配可用空间。
// Expanded 不能直接放在 Align 的 child 下
// Expanded 只能作为 Row、Column、Flex 的直接子组件。
// widthFactor/heightFactor 作用对象是 Align，不是 child
// 不会放大缩小子组件，只是扩大 Align 的容器范围。
// Align 只能有一个 child；多个组件用 Column/Row 包起来作为 child

// 如果需求仅仅是为组件添加间距，那么直接使用Padding

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
          // padding: EdgeInsets.all(20),  // 在container直接用padding也是可以的
          decoration: BoxDecoration(color: Colors.amber),
          // 这里是使用的padding组件
          child: Padding(
            padding:EdgeInsets.all(20),  // 必传参数
             child: Container(color: Colors.blue),
          )
        ),
      ),
    );
  }
}
// center 是align的一个特例，继承自align，相当于一个将alignment属性为居中的Align.center
// 使用场景是需要一个子组件放在父组件的位置