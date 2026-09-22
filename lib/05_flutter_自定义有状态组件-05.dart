
// import 'package:flutter/foundation.dart';
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

// 有状态组件
// 具体的页面 类  理解：开发者现在要开发个首页 面向对象编程
class MainPage extends StatefulWidget {

  const MainPage({super.key});
  // 这里其实是可以声明参数和数据的 也就是 成员属性 方便传递

  //========createState是statefulwidget的抽象方法，必须重写
  //========返回的是state子类对象，这个state对象就是用来保存组件状态，调用setState,写build()的具体业务类
  //========<>可以写MainPage 说明是mainpage页面来控制状态
  //========`createState()` 的作用：**把 Widget（配置）和 State（状态）绑定在一起
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

// ====第二个类 是具体的业务类，负责 管理数据 处理业务逻辑 并且渲染视图
// ====因为该类仅在当前文件使用 也只针对 首页的业务逻辑 故可以写私有类
// ====所有`State`子类必须实现`build`，它是抽象方法，不写直接报错
// ====state是一个状态对象，<>说明状态是跟谁【那个页面】绑定的
// ====感觉这个state就是监听整个页面的所有触发事件
class _MainPageState extends State<MainPage> {

  // ====build 方法详解
  // ====build 方法 是组件渲染回调，框架调用这个方法**构建UI树**，状态变化时会重新执行 build 刷新界面
  // ====这里的Widget其实就是 mainPage页面 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // 这里开始写跟窗口的 UI布局代码
      title: "hello world",
      theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      // 窗口主体
      home: Scaffold(
        appBar: AppBar(title: Text("头部区域"), centerTitle: true),
        body: Container(child: Center(child: Text("中间区域"))),
        // 自己的扩展
        bottomNavigationBar: Container(
          // 容器是可以设置高度的
          height: 80,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              // mainAxisSize:MainAxisSize.min 设置 多打的内容 占多大
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.home), Text("首页")],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.person), Text("我的")],
              ),
            ],
            // child: Text("底部区域"),
          ),
        ),
      ),
    );
  }
}
