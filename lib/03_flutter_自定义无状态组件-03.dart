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
    // TODO: implement build
    // throw UnimplementedError();
    return MaterialApp(
      // 这里开始写跟窗口的 UI布局代码
      title: "hello world",
      theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      // 窗口主体
      home: Scaffold(),
    );
  }
}
