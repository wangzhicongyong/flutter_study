import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '47_flutter_网络请求封装dio插件-47.dart';
import 'package:logger/logger.dart';
import 'package:json_annotation/json_annotation.dart';
part '49_flutter_获取数据模型处理方案-49.g.dart';
// import 'package:flutter_application_1/49_flutter_获取数据模型处理方案-49.g.dart';

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

// +++++++++++++++++++++++++++++++ 频道数据结构模型类++++++++++++++++++++++++++++++++++++++++++++
// Dart + json_serializable 模型类用 **`final`**，是 Dart 不可变编程风格 + 序列化库最佳实践，**模型实体一旦构造完成，字段就不允许修改
@JsonSerializable()
class ChannelModel {
  final String id; // 变量只能赋值一次，实例创建完成后**不可修改**
  final String name;

  // 有参构造函数
  ChannelModel({required this.id, required this.name});

  // 使用该方法再包装一下
  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
}

class _MainPage extends State<MainPage> {
  @override
  void initState() {
    super.initState;
    // 热重载不执行初始化函数
    // 获取频道数据
    _getChannels();
  }

  // 目前flutter最流行的三种数据解析方法：
  // ____________________________________________1. ✅ **json_serializable（官方推荐，工业首选）** 代码生成模型类
  // ____________________________________________2. ✅ **json_annotation + 手写 fromJson（轻量，简单接口）**
  // ____________________________________________3. ✅ **dart_mappable（新热门，更少样板代码，不用写 factory）**
  // 用来接收数据
  // 在 pubspec.yaml 里加依赖：json_annotation、build_runner、json_serializable
  void _getChannels() async {
    // 发送网络请求
    Response<dynamic> result = await DioUtils().get("channels");
    // log.d("==============$result=============");
    // print(result.runtimeType);
    // print(result.data); // `result.data` 是接口返回的 json 对象
    final data = result.data;
    // 数据转义 其实是需要做空安全检验的 和类型判断  `is!`：**判断对象不是某个类型**
    if (data == null || data is! Map<String, dynamic>) {
      // 报异常
      log.e("返回数据格式错误,不是Map");
      return;
    }
    Map<String, dynamic> res = data;
    // _____________1.自动生成的解析函数是可以直接使用的，因为 part '49_flutter_获取数据模型处理方案-49.g.dart'; 说明它是该当前库的一部分
    // 模型 fromJson 接收的是**单个 json 对象 (Map)**，不是数组
    // 后端返回的是一个Map 里面包含着 maps数组
    // 先取出data
    final responseData = res["data"];
    if (responseData == null || responseData is! Map<String, dynamic>) {
      log.e("responeseData为空或者是不是Map类型");
      return;
    }
    // 3. 拿到 channels 数组
    final channelsArr = responseData["channels"];
    if(channelsArr == null || channelsArr is! List){
      log.e("channels 不是数组");
      return;
  }
    // 遍历数组
    List<ChannelModel> _list = channelsArr.map((item){
      // 此方法接收的是单个map 
      return ChannelModel.fromJson(item as Map<String, dynamic>);
    }).toList();
      log.d("==============$_list=============");
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
          title: Text("频道管理", style: TextStyle(color: Colors.red)),
        ),
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
