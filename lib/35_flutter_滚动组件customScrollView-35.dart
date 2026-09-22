// ====用于组合多个可滚动组件（列表，网格）实现统一协调的滚动效果
// ====sliver flutter中描述可滚动视图内部一部分内容的组件，它是滚动视图的切片
// 做部分的内容滚动  部分内容滚动
// 通过slivers 属性接受一个sliver组件列表
// minExtent：组件本身最小尺寸 / 占比（FlexibleSpaceBar / DraggableSheet / Sliver）
// minScrollExtent：滚动可到达的 最小滚动像素偏移
//`CustomScrollView`：单一滚动容器，内部只能放 Sliver 系列组件**，多个 Sliver 共用一套滚动偏移、滚动控制器、滚动物理，实现**混合滚动布局**（头部伸缩、吸顶、列表 + 网格混排）CSDN博...
// sliverList  sliverGrid  sliverAppBar sliverPadding sliverToBoxAdapter

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return _Homepage();
  }

  @protected
  List<Widget> getList() {
    // Dart 会隐式返回`null`  必须是返回 widget
    return List.generate(100, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }
}

class _Homepage extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("customScrollView代码示例"),
        ),
        // **Sliver**：中文叫薄片，是适配滚动视口的特殊组件，
        //名字都以 `Sliver` 开头；Sliver 不能直接放到 `Column/Row`，
        //普通 Box Widget 不能直接放进 `slivers` 数组，需要 `SliverToBoxAdapter` 包装Flutter
        body: CustomScrollView(
          // SliverToBoxAdapter用于包裹普通的widget
          // 轮播图
          slivers: [SliverToBoxAdapter(
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              height: 260,
              child: Text("轮播图", style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ),
          SliverToBoxAdapter(child: Container(
            height: 10,
          ),),
          // **Flutter 3.24.0 新增的 Sliver 组件**，属于 `widgets` 包，放在 `CustomScrollView` 的 slivers 数组中使用Flutter
          // 替换 SliverPersistentHeader 这一段
          // 适合：滚动时动态弹出操作栏、筛选栏、悬浮工具栏这类场景
          // 这个枚举是 Flutter 3.27 新增，配合 `SliverFloatingHeader` 使用，它**只有两个成员**
          // 向下滚显示，向上滚隐藏（浮动弹出）
          SliverFloatingHeader(
            snapMode: FloatingHeaderSnapMode.overlay,
            // snapMode: null,
            // 往下滚动会悬浮吸顶
            // snapMode: FloatingHeaderSnapMode.scroll,
            // 一共4个参数
            // 封装动画参数
            animationStyle: AnimationStyle(
              // 正向动画时长
              duration: Duration(milliseconds: 20),
              // 正向动画曲线 
              curve: Curves.easeOut,
              ),
            child: Container(
              height: 60,
              color: Colors.orange,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("悬浮吸附Header"),),
              ),
          
            SliverList.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  // 如果是在builder构造函数里面设置了每条固定高度，以此高度为主
                  height: 80, 
                  color: Colors.blue,
                  child: Text("我是第${index + 1}个", style: TextStyle(color: Colors.white),),
            );
          },
              )
          ],
        )
      ),
    );
  }
}

// `SliverFloatingHeader` 是 3.24 新增的组件，自带吸附能力，配置 `snapMode`，不需要手写 delegate 和 snapConfiguration：
// `get`：Dart 只读访问器，调用时不用加 `()`，直接 `obj.minExtent`
class _StickCategory extends SliverPersistentHeaderDelegate{

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    // 返回的是顶部下面的 item 吸顶 
    return Container(
      // `margin` 是组件 外部留白
      // 左右相同、上下相同
      // margin: const EdgeInsets.symmetric(horizontal: 50),  // 左右间距
      // margin: EdgeInsets.symmetric(vertical: 50),  // 垂直间距
      color: Colors.white,
      child: ListView.builder(
        // itemExtent: 30,  // 固定高度
        // 最后一个item 预留边界距离 20
        // 全局左右边预留20的空白
        // ListView 自身 padding：**滚动内容两端留白**，右 padding 要滑到底才看得见。
        padding: const EdgeInsets.symmetric(horizontal: 20), // ✅ 整个列表左右预留20
        itemCount: 30,
        scrollDirection: Axis.horizontal, // 横向排列
        itemBuilder: (BuildContext context, int index){
          return Container(
            // 设置最大高度
            // height: maxExtent,
            // 设置水平方向的间距
            margin: const EdgeInsets.symmetric(horizontal: 10),
             // 宽
            width: 80,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("分类${index + 1}", style: TextStyle(color: Colors.white, fontSize: 20),),
          );
        },
        ),
    );
  }

  // `get`：Dart 只读访问器，调用时不用加 `()`，直接 `obj.minExtent`
  // 最小高度
  // 和maxExtent一致，固定高度，防止压缩
  @override
  double get minExtent => 60;  // 收缩到最小时的高度  `initialExtent`：初始高度比例 最小高度

  // 等价写法
  // minExtent：组件本身最小尺寸 / 占比（FlexibleSpaceBar / DraggableSheet / Sliver）
// @override
// double get minExtent {
  // return 200;
// }

  @override
  double get maxExtent => 60;  // 展开最大高度

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  // 关闭拉伸  flutter >=3.24 已经移除该组件
  // @override
  // OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  // 浮动吸附配置
  // @override
  // FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  }