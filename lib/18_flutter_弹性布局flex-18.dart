// flex 允许岩一个主轴排列其子组件，灵活的控制这些子组件在主轴上的尺寸比列和空间分配
// expanded flexible作为flex的子组件通过flex属性来分配flex空间
// row column都继承自flex
// 日常优先写 Row / Column；**只有需要动态切换横竖方向的时候才直接用 Flex**
// Flex 容器占满父给的主轴全部空间  也是默认的
// stretch 是父约束，优先级高于子组件自身 width/height
// Expanded **只能直接放在 Flex / Row / Column 的 children 里面**，放别的组件
// Expanded 不能嵌套在普通 Container 里面，必须是 Flex 直接子节点，否则报错
// Expanded 本身没有宽高，它不代表 UI 盒子，它是一个**布局约束包装器**，告诉父 Flex：把剩余空间分我一份。
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
          decoration: BoxDecoration(color: Colors.blue),
          // flex也是默认最大沾满父组件空间
          child: Flex(
            // mainAxisSize: MainAxisSize.min,
            // 此参数是必传
            direction: Axis.horizontal,  // 决定子组件的排列方向
            children: [
              // `Expanded` = `FlexFit.tight`：**强制 child 填满分配到的全部空间**
              // expanded 就3个参数
              Expanded(
                // 分配剩余的空间 权重
                flex: 1,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber,
                ),),
                // flexible 是4个参数  默认是 `Flexible(..., FlexFit.loose)`：给 child 最大可用空间，但 child 可以更小，不强制撑满
                Flexible(  // 这里可以做到和expanded 的效果是一样的
                  fit: FlexFit.tight,
                  flex: 1,  // 所有长度的 3分之2
                  child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),)
            ],
          ),
        ),
      ),
    );
  }
}