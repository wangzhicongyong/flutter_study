// 作用：用于实现分页滚动视图的核心组件
// 提供多种构建方式，默认构造方式，pageView.builder
// 优势：支持懒加载
// 绑定controller属性，对象类型为PageController
// 切换方法  跳转控制 切换方法 controller.jumpPage animateToPage

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PageViewDemo());
  }
}

class PageViewDemo extends StatefulWidget {
  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  // 定义控制器
  final PageController _controller = PageController();
  // 当前索引
  int _currentIndex = 0;

  // 页面销毁时释放控制器
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // const int _currentIndex = 0;

    return Scaffold(
      // 层叠布局
      body: Stack(
        children: [
          // PageView 的拖拽识别默认只识别**触摸事件（触屏）**； 在web端无法滑动
          // 电脑鼠标，按住左键拖动，默认**不会触发 PageView 翻页**
          // 打开浏览器开发者工具，开启手机模拟器（触屏模式），再拖动 → 轮播可以滑动
          PageView.builder(
            // 控制器
            controller: _controller,
            itemCount: 5,
            // **页面切换成功后触发，传入当前页码 / 索引**，常用于翻页后加载数据、更新状态GitHub
            // 页面切换后触发回调函数
            // 捕捉到状态变化
            onPageChanged: (idx) => setState(() => _currentIndex = idx),
            // 根据索引取值
            itemBuilder: (ctx, idx) {
              return ColoredBox(
                color: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.amber,
                ][idx],
                child: Center(
                  child: Text(
                    "轮播图${idx + 1}",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              );
            },
          ),
          // 底部圆点指示器
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                // 使用点击事件包裹住 GestureDetector
                return GestureDetector(
                  onTap: () {
                    // 切换索引
                    _controller.jumpToPage(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    // dart 条件为true时，返回值1
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: index == _currentIndex
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
