// 实现文本输入功能的核心组件

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
    return List.generate(10, (index) {
      return Container(height: 100, width: 100, color: Colors.blue);
    });
  }
}

class _Homepage extends State<Homepage> {
  // 文本控制器
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true, // 导航标题居中
          title: Text("textfield代码示例"),
        ),
        body: Container(
          // 设置内边距
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  print(value);
                },
                // 绑定控制器
                controller: _phoneController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  // 前置图标
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  suffixIcon: Icon(Icons.clear, color: Colors.blue), //后置图标
                  // labelText: "请输入账号",
                  hintText: "请输入账号", // 提示文字
                  // 输入框颜色
                  fillColor: const Color.fromARGB(255, 224, 224, 209),
                  // 允许填充背景颜色
                  filled: true,
                  // 外边框
                  border: OutlineInputBorder(
                    // 无边框
                    // borderSide: BorderSide.none,
                    // 圆角
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              // 空白占位  column和row 隔开
              SizedBox(height: 20),
              TextField(
                controller: _pwdController,
                // 隐藏密码明文显示
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.blue,
                  ),
                  // labelText: "账号",
                  hintText: "请输入密码", // 提示文字
                  fillColor: const Color.fromARGB(255, 222, 219, 207),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // 无边框
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () {
                    String str = _phoneController.text;
                    print(str);
                  },
                  child: Text("登录", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
