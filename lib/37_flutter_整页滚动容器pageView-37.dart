import 'package:flutter/material.dart';
import 'dart:async';

void main(List<String> args) {
  // runaAPP 接收的参数是 根 widget窗口
  runApp(PageViewDemo());
}

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({super.key});

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  late PageController _controller;
  int _currentIndex = 0;
  // 全局
  late Timer _timer;
  // 真是页面数量是3个
  int itemCount = 3;

  // 初始化状态
  @override
  void initState() {
    super.initState();
    // 初始化页面控制器
    // 初始定位到很大的中间位置，实现无限左右滑动
    _controller = PageController(initialPage: itemCount * 1000);
    _currentIndex = itemCount * 1000;

    // 自动轮播定时器  周期性定时器
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int next = _currentIndex + 1;
      if (next >= 3) {
        next = 0;
      }
      ;
      // 页面切换
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  // 问题1：切换的动画方向不是统一的向左滑动。最后一个切换到第一个是往左切的？
  // 想要**统一向右滑动的动画**（3→1 的时候也是往右滑，不是往回退），有两种方案
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: (idx) => setState(() => _currentIndex = idx),
          children: const [
            ColoredBox(
              color: Colors.red,
              child: Center(child: Text("1", style: TextStyle(fontSize: 20))),
            ),
            ColoredBox(
              color: Colors.green,
              child: Center(child: Text("2", style: TextStyle(fontSize: 20))),
            ),
            ColoredBox(
              color: Colors.blue,
              child: Center(child: Text("3", style: TextStyle(fontSize: 20))),
            ),
            ColoredBox(
              color: Colors.pink,
              child: Center(child: Text("4", style: TextStyle(fontSize: 20))),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 记得销毁定时器！你原来代码没cancel，会内存泄漏
    // 没有 `_timer.cancel()`，页面销毁后定时器还在跑，内存泄漏
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
