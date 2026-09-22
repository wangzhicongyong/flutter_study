import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';

void main(List<String> args) {
  // runaAPP 接收的参数是 根 widget窗口
  runApp(GenWidget());
}

// 创建日志器
final log = Logger();

// ===================================== 封装根widget窗口对象 MaterialApp=====================================
// 无状态组件 最好是做静态内容展示，外观仅有配置文件确定
//=============有状态组件是构建动态交互界面的核心，能够管理变化的内部状态，当状态改变时，组件会更新显示内容===========
//=============实现1：创建两个类，第一个类继承statefulWidget 主要接收和定义最终参数，核心作用是创建state对象=======
//=============实现2：第二个类继承state<第一个类名>，负责管理所有可变的数据和业务逻辑，并实现build的构建方法=======
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

// ======================================封装首页的骨架 Scaffold ==============================
// 此处设计到动态交互 股用有状态组件 statefulWidget 因为它是抽象类 需要重写它定义的方法
class Homepage extends StatefulWidget {
  // 定义参数 实际就是定义成员属性
  final String title;

  // 对象初始化构造函数
  const Homepage({super.key, required this.title});

  // 重写该方法是绑定那个页面的状态 来控制状态 语法：页面名称 createState(){}
  // 返回：state 实列对象  绑定到 homepage
  @override
  State<Homepage> createState() {
    return _Homepage();
  }

}

// 具体的动态交互逻辑 使用类 并且此类仅在该库/文件里面使用  因为该页面写的一个具体的页面交互逻辑
// 该类需要去继承绑定状态 具体页面
// state 的子类必须重写build（）
class _Homepage extends State<Homepage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 这里封装 业务逻辑 只有在state 状态类 捕捉事件
    return Scaffold();
  }
}
