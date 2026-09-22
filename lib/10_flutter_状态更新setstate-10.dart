// ui视图需要进行相应更新
// 数据的变化要更新UI视图，需要执行setState（），它会造成 build方法重新执行
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';

void main(List<String> args) {
  // runaAPP 接收的参数是 根 widget窗口
  runApp(Homepage(title: "测试flutter"));
}

// 创建日志器
final log = Logger();

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
class _Homepage extends State<Homepage> {
  // 需求是做 点击具体的按钮，按钮的文字变绿色 高亮
  // 记录当前选中的下标， 0 微信 1是 通讯录 2 是发现  3 是我的
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // 这里封装 业务逻辑 只有在state 状态类 捕捉事件
    return MaterialApp(
      title: "hello world",
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue),
      // 窗口主体
      home: Scaffold(
        appBar: AppBar(title: Text("头部区域"), centerTitle: true),
        body: Container(
          child: Center(
            // 添加点击事件
            child: GestureDetector(
              onTap: () {
                // 传入onTab方法
                print("点击了该区域");
              },
              child: Text("中间区域"),
            ),
          ),
        ),
        // 自己的扩展
        bottomNavigationBar: BottomNavigationBar(
          // 初始化索引
          currentIndex: _currentIndex,
          // 选中文字颜色绿色
          selectedItemColor: Colors.green,
          // 没有选中是灰色
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              // 未选中时显示的图标
              icon: Icon(Icons.chat_bubble_outline),
              // 选中时显示的图标
              activeIcon: Icon(Icons.chat_bubble),
              label: "微信",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined),
              activeIcon: Icon(Icons.contacts),
              label: "通讯录",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: "发现",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "我",
            ),
          ],
          onTap: (index) { // 事件函数的业务逻辑写在setState里面 
            // 点击。更新选中下索引
            // 告诉 Flutter，这个状态对象的数据变了，请重新执行一次 build ()，刷新 UI 无返回值
            setState(() {
              _currentIndex = index;
              log.d("=============$_currentIndex==================");
            });
          },
        ),
      ),
    );
  }
}
