import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '47_flutter_网络请求封装dio插件-47.dart';
import 'package:logger/logger.dart';

void main() {
  // myapp（）是widget对象
  runApp(MainPage());
}

// 创建日志器
final log = Logger();

// StatelessWidget 是无状态组件 没有state对象  没有setState（）方法 所有属性必须是 final, UI 完全靠构造函数传入参数决定
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  @override
  void initState() {
    super.initState;
    // 热重载不执行初始化函数
    // 获取频道数据
    _getChannels();
  }

  // 用来接收数据
  List<Map<String, dynamic>> _list = [];
  void _getChannels() async {
    // 发送网络请求
    Response<dynamic> result = await DioUtils().get("channels");
    // log.d("==============$result=============");
    // print(result.runtimeType);
    // print(result.data); // `result.data` 是接口返回的 json 对象
    // 数据转义 其实是需要做空安全检验的
    Map<String, dynamic> res = result.data as Map<String, dynamic>;
    // 强转列表类型
    List data = res["data"]["channels"] as List;
    // 简化写法
    // `cast()` 是**惰性包装**，不是立刻遍历转换
    // 只有你读取数组元素的时候才校验类型；数组里面有一个不是 Map，访问时才炸，不是解析时立刻报错
    // _list = data.cast<Map<String, dynamic>>() ?? [];
    // log.d("==============$_list=============");
    // log.d("++++++++++++++${_list.runtimeType}+++++++++++++");
    // 这种写法是 会立马生成一个新的 list
    _list = data.map((item) => item as Map<String, dynamic>).toList() ?? [];
    log.d("------------------$_list-------------");
    log.d("++++++++++++++${_list.runtimeType}+++++++++++++");
  }

  @override
  Widget build(BuildContext context) {
    // Theme.of(context).colorScheme.primary;
    // **MaterialApp**：**根**，全局，管主题、路由,整个 APP 只写一次
    return MaterialApp(
      title: '频道管理', // 任务窗口主题 浏览器打开的页面标签
      // 关闭右上角debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.red.shade200)),
      themeMode: ThemeMode.system, // system跟随系统 light浅色 dark深色
      // 指定主页 默认首页
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("频道管理", style: TextStyle(color: Colors.red),)),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("父组件", style: TextStyle(color: Colors.blue, fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
