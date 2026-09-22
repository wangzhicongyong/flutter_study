import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '47_flutter_网络请求封装dio插件-47.dart';
import 'package:logger/logger.dart';
import 'package:json_annotation/json_annotation.dart';
part '51_flutter_网络请求父传子实现-51.g.dart';

void main() {
  // myapp（）是widget对象
  runApp(MainPage());
}

// 创建日志器
final log = Logger();

//*******************有状态组件是【父】，无状态组件是【子】（最常用） */
//*******************父把数据传给子，同时传**回调函数**。子无状态组件触发事件（点击等），调用回调，通知父执行 setState 更新状态 */

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPage();
  }
}

// +++++++++++++++++++++++++++++++ 频道数据结构模型类++++++++++++++++++++++++++++++++++++++++++++
// Dart + json_serializable 模型类用 **`final`**，是 Dart 不可变编程风格 + 序列化库最佳实践，**模型实体一旦构造完成，字段就不允许修改
// 数据解析方法自动生成：先执行：flutter pub run build_runner build
// ==# 如果文件缓存冲突，清理再生成
// flutter pub run build_runner build --delete-conflicting-outputs
// 如果模型有改变，重新执行就可以
@JsonSerializable()
class ChannelModel {
  final int id; // 变量只能赋值一次，实例创建完成后**不可修改**
  final String name;

  // 有参构造函数
  ChannelModel({required this.id, required this.name});

  // 使用该方法再包装一下
  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
}

// ================================= 主页状态控制类=========================================
class _MainPage extends State<MainPage> {

  // 类成员变量
  late List<ChannelModel> _list = [];

  @override
  void initState() {
    super.initState();
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
    // 页面已经销毁，直接return，不执行setState 请求还没有完成，用户就已经退出页面 请求终止
    if(!mounted) return;
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
    if (channelsArr == null || channelsArr is! List) {
      log.e("channels 不是数组");
      return;
    }
    // 遍历数组
    // `List<ChannelModel> _list = xxx` 新建局部变量；`_list = xxx` 才是修改 state 里面的成员变量，`setState`才能感知变化
    // 状态监听
    // 此处为什么是这样写的原因？
    // ======================1._list 是_MainPage这个State 对象的成员变量
    // ======================2.网络请求拿到数据，赋值给_list→ 变量变了,但 Flutter**不知道**
    // ======================3.`setState((){})` 触发 `build()` 重新执行 → GridView 读取新的 `_list`，渲染新的子组件
    // 标准写法：setState函数是监听 修改状态代码的
    setState(() {
       _list = channelsArr.map((item) {
      // 此方法接收的是单个map
      return ChannelModel.fromJson(item as Map<String, dynamic>);
    }).toList();
    });
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade200),
      ),
      themeMode: ThemeMode.system, // system跟随系统 light浅色 dark深色
      // 指定主页 默认首页
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("频道管理", style: TextStyle(color: Colors.red)),
        ),
        // 不用指定列数，自适应列数
        body: GridView.extent(
          // item的内边距
          padding: EdgeInsets.all(10),
          // item的最大宽度
          maxCrossAxisExtent: 60,
          // 行与行之间的间距
          mainAxisSpacing: 10,
          // 列与列之间的间距
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
          children: List.generate(_list.length, (index) {
            return ChannelItem(name: _list[index].name);
          }),
        ),
      ),
    );
  }
}

// 无状态子组件
class ChannelItem extends StatelessWidget {
  // 名称
  final String name;

  const ChannelItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      width: 60,
      color: Colors.blue,
      alignment: Alignment.center,
      // 自动缩放文字，保证文字完整塞进盒子，不会溢出,适合单行文本
      child: FittedBox(
        // 文字自适应大小
        fit: BoxFit.scaleDown, // 文字太长才缩小；文字短就保持原生大小，**不会强行放大文字**（最常用）
        child: Text(name, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
