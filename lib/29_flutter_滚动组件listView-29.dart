// 包裹一个子组件,让组件具备滚动功能，所有内容是一次性渲染
// 提供多种构造函数
// 采用按需渲染（懒加载）,只构建当前可见区域的列表项，极大提升长列表性能
// 原因：Column 不限制子组件高度，ListView 默认占满全部可用空间，两者冲突。
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
  // 定义文本控制器

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("textfield代码示例"),
        ),
        body: ListView.builder(
          itemExtent: 50, // 每条item固定高度80，性能大幅提升
          itemCount: 100,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.blue,
              // 如果是在builder构造函数里面设置了每条固定高度，以此高度为主
              height: 400, 
              child: Text(
                "我是第${index + 1}个",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  validator(value) {
    if (value == null || value.isEmpty) return "密码不能为空";
    return null;
  }
}
