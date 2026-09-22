
import 'package:flutter/material.dart';

void main() => runApp(const ParentPage());

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {

  String msg = "来自父组件的数据";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ 父组件：实例化子组件，直接传参 子组件是个 column
              ChildWidget(text: msg, num: count),
              // 按钮组件 填充+阴影，高强调 主按钮
              ElevatedButton(
                onPressed: () {
                  // 状态 同步执行，触发build 重新构造UI
                  setState(() {  // 使用setsate来更新数据 首先Count是全局变量，会保存更新的数据
                    count++;
                    msg = "父更新：$count";  // 父组件是有状态组件 msg 是可变的 
                  });
                },
                // 自定义按钮 对按钮重新做UI
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // 背景
                  foregroundColor: Colors.white, // 文字/图标颜色
                  elevation: 8, // 阴影高度
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 圆角
                ),
                minimumSize: const Size(120, 48), // 最小尺寸
                ),
                // 按钮文字
                child: const Text("父组件更新数据"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 子组件：所有接收参数必须 final，不可变
class ChildWidget extends StatelessWidget {
  final String text;
  final int num;
  // required 标识必传参数，super.key 规范写法
  const ChildWidget({super.key, required this.text, required this.num});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("子组件接收：$text"),
        Text("数字：$num"),
      ],
    );
  }
}