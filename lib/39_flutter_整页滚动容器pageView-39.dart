import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logger/logger.dart';

void main(List<String> args) {
  // runaAPP 接收的参数是 根 widget窗口
  runApp(PageViewDemo());
}

// 创建日志器
final log = Logger();

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({super.key});

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

// =====================自动实时轮播图实现逻辑=============================
// 1.定时器维护的大索引和UI展示的索引是不一样的
// 2.UI真实展示的索引是 大索引取余数 取的
// 3.核心：页面控制器起始索引 最好是取中间，假象：索引是4000，往回退也可以，往前滚动也是可以
// 4.核心：往前滚动的边界值 最好是大于起始页面索引的几倍大 留大量的空间，也可以做边界判断，防止出现异常
// 5.PageView.builder的itemCount是页面总数，索引从 0 开始，最大索引 = itemCount-1，不能访问 >=itemCount 的索引**
// 6.但是真实页面个数是 4个
// 7.onPageChanged函数是页面切换后，就进行回调，index是当前页面的索引
// 8.此版本是：实时滚动，不能进行手动滚动

class _PageViewDemoState extends State<PageViewDemo> {
  // 懒加载
  late PageController _controller;
  // 全局
  late Timer _timer;
  // 真是页面数量是4个
  int itemCount = 4;
  // 定时器维护的滚动索引
  late int _targetPageIndex;
  // 实时页面当前索引
  int _currentIndex = 0;

  // 初始化状态
  // 布局开始构造组件树时 调用该函数
  @override
  void initState() {
    super.initState();
    // 初始化 定时器起始索引  2000
    _targetPageIndex = itemCount * 1000;
    // 初始化页面控制器
    // 初始定位到很大的中间位置，实现无限左右滑动
    _controller = PageController(
      // 初始化起始展示页的 索引  这样是4000  左边还有几千 后面还有几千  可以无限滑动 无法达到边界
      initialPage: _targetPageIndex,
    );

    // 自动轮播定时器  周期性定时器
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // 定时器定时给当前索引做递增+1
      _targetPageIndex = _targetPageIndex + 1;
      log.d("==============定时器维护的索引值是：$_targetPageIndex=============");
      // 然后开始执行动画跳转
      // 动画切换后，执行**PageView 触发 onPageChanged**，把真实的 page index 重新赋值给 `_currentIndex`
      _controller.animateToPage(
        _targetPageIndex, // 跳转到指定索引页
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  // ===========PageView.builder + 超大索引无限轮播原理========================
  // 问题1：切换的动画方向不是统一的向左滑动,最后一个切换到第一个是往左切的？
  // 想要**统一向右滑动的动画**（3→1 的时候也是往右滑，不是往回退），有两种方案
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView.builder(
          // 禁止手势切换
          // physics: const NeverScrollableScrollPhysics(), // 禁止手势拖动
          controller: _controller,
          // 页面切换时回调
          onPageChanged: (index) => setState(() {
            // 当前页索引 获取切换到的当前页索引 index就是初始化的 索引
            // 执行，把当前的index 索引赋值给 _currentIndex 覆盖
            _currentIndex = index;
            // 核心：手动滑动页面后，同步定时器的目标索引，保证轮播不错位
            _targetPageIndex = _currentIndex;
            
            log.d("==============onPageChanged函数当前页面的索引值是: $index=============");
          }),
          // 给一个超大的数量 item  有滚动的空间
          itemCount: itemCount * 1000 *5,
          itemBuilder: (BuildContext context, int index) {
            // 取模拿到真实页面
            int realIndex = index % itemCount;
            // log.d("==============第一次起始的值是$realIndex=============");
            // `oloredBox` 是**只用来填充纯色背景**的轻量 Widget，Flutter 内置，推荐在仅需要背景色时替代 `Container(color: xxx)`，性能更好，支持 `const` 构造Flutter。
            switch (realIndex) {
              case 0:
                return const ColoredBox(
                  // 没有宽高
                  color: Colors.red,
                  child: Center(
                    widthFactor: 2,
                    heightFactor: 2,
                    child: Text("1", style: TextStyle(fontSize: 20)),
                  ),
                );
              case 1:
                return const ColoredBox(
                  color: Colors.green,
                  child: Center(
                    widthFactor: double.infinity,
                    heightFactor: double.infinity,
                    child: Text("2", style: TextStyle(fontSize: 20)),
                  ),
                );
              case 2:
                return const ColoredBox(
                  color: Colors.blue,
                  child: Center(
                    widthFactor: double.infinity,
                    heightFactor: double.infinity,
                    child: Text("3", style: TextStyle(fontSize: 20)),
                  ),
                );
              case 3:
                return const ColoredBox(
                  color: Colors.orange,
                  child: Center(
                    widthFactor: double.infinity,
                    heightFactor: double.infinity,
                    child: Text("4", style: TextStyle(fontSize: 20)),
                  ),
                );
              default:
                return const SizedBox();
            }
          },
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
