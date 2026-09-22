// container 基础布局组件，可以方便的容纳一个组件 多功能组合容器
// 基础容器：container center align padding
// 尺寸控制
// 优先级 明确宽高>container约束>父组件约束>自适应组件大小
// 装饰系统 通过decoration 属性实现视觉效果，但和color属性互斥
// 布局控制：提供内外边距和对齐方式
// 可选变化：旋转 平移
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main(List<String> args) {
  // runaAPP 接收的参数是 根 widget窗口
  runApp(GenWidget());
}
// 创建日志器
  final log = Logger();
// 封装根widget窗口对象
// 无状态组件 最好是做静态内容展示，外观仅有配置文件确定
class GenWidget extends StatelessWidget {
  // 创建 genWidget 对象  构造函数  使用const
  // const GenWidget(Key? key) : super(key: key);
  // 简写构造函数  使用const可以复用该跟窗口 不用反复创建
  const GenWidget({super.key});

  // 因为是继承的抽象类  需要重写build方法
  // build 方法主要是拿来也ui的布局 返回一个 根窗口实列  build 只写 UI 组装代码
  // 组件第一次渲染的时候 调用
  // build 方法会多次调用 符和子的渲染
  @override
  Widget build(BuildContext context) {
    log.d("==============测试信息=============");
    return MaterialApp(
      // 这里开始写跟窗口的 UI布局代码
      title: "hello world",
      theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      // 窗口主体
      home: Scaffold(
        // container 的alignment 控制的是它的直接子组件
        body: Container(
          // 设置旋转  z 是面向我旋转 0.05是弧度
          transform: Matrix4.rotationZ(0.05),
          // 设置边距 外边距 盒子外部 和别的组件之间的距离
          // padding 盒子内部，child和盒子边框之间的距离
          // margin: EdgeInsets.all(20),  // 四周统一  vertical 是垂直方向  horizontal 是水平方向的
          // margin: EdgeInsets.symmetric(vertical: 40, horizontal: 40),  // 上下  左右
          margin: EdgeInsets.fromLTRB(10, 20, 30, 40),  // 左 上 右 下
          padding: EdgeInsets.all(16),
          width: 200,
          height: 200,
          // 针对container 进行装饰  做圆角 边框 阴影 渐变 图片背景 都是用 BoxDecoration
          decoration: BoxDecoration(
            // 设置container背景图
            color: Colors.white,
            // 1000是圆形 设置圆角  
            borderRadius: BorderRadius.circular(16),
            // 设置边框
            border: Border.all(width: 3, color: Colors.amber),
            ),
          // 设置居中 alignment 只对 Container直接child生效子组件居中
          alignment: Alignment.center,
            child: Text("hello Container"),

        ),
      ),
    );
  }
}
