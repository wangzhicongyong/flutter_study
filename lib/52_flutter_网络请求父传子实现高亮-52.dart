import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '47_flutter_网络请求封装dio插件-47.dart';
import 'package:logger/logger.dart';
import 'package:json_annotation/json_annotation.dart';
part '52_flutter_网络请求父传子实现高亮-52.g.dart';

void main() {
  runApp(MainPage());
}

// 创建日志器
final log = Logger();

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPage();
  }
}

@JsonSerializable()
class ChannelModel {
  final int id; // 变量只能赋值一次，实例创建完成后**不可修改**
  final String name;

  // 有参构造函数
  ChannelModel({required this.id, required this.name});

  // 使用该方法再包装一下 接收的是单个字典
  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
}

// ================================= 主页状态控制类=========================================
class _MainPage extends State<MainPage> {
  // 记录当前选中频道ID，状态放在父组件
  int? _selectedId;
  // 类成员变量
  late List<ChannelModel> _list = [];

  @override
  void initState() {
    super.initState();
    // 热重载不执行初始化函数
    // 获取频道数据
    _getChannels();
  }

  void _getChannels() async {
    // 发送网络请求
    Response<dynamic> result = await DioUtils().get("channels");
    // 页面已经销毁，直接return，不执行setState 请求还没有完成，用户就已经退出页面 请求终止
    if (!mounted) return;
    final data = result.data;
    // 数据转义 其实是需要做空安全检验的 和类型判断  `is!`：**判断对象不是某个类型**
    if (data == null || data is! Map<String, dynamic>) {
      // 报异常
      log.e("返回数据格式错误,不是Map");
      return;
    }
    // 创建一个变量
    Map<String, dynamic> res = data;
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
            return ChannelItem(
              id: _list[index].id,
              name: _list[index].name,
              // 子组件当前选中id
              isSelected: _list[index].id == _selectedId,
              onTap: () {
                // ========== 核心回调函数 ==========
                // 子点击后，执行这个函数（函数定义在父State里面）
                setState(() {
                  // 更新父组件的选中状态 点击哪个频道 则将当前频道的id 赋值给 父组件的 选中id
                  if (_list[index].id == _selectedId) { // 第一次点击赋值
                    _selectedId = null;
                  }else{
                     _selectedId = _list[index].id;
                  }
                });
              },
            );
          }),
        ),
      ),
    );
  }
}

// 无状态子组件
class ChannelItem extends StatelessWidget {
  final int id;
  // 名称
  final String name;
  final bool isSelected;
  // 子组件接收回调函数，点击触发
  final VoidCallback onTap;

  const ChannelItem({
    super.key,
    required this.name,
    required this.id,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // InkWell是 Flutter 自带的**手势响应组件**，专门用来做点击，自带**水波纹点击效果**
    // 它本身不是容器，是一个**包装器组件**：包裹别的 Widget，给内部组件增加点击能力
    return InkWell(
      onTap: onTap, // 1.这个回调函数是在子类定义；2.点击触发父传进来的回调（真正的回调函数业务在父组件里面写）
      child: Container(
        padding: EdgeInsets.all(10),
        height: 60,
        width: 60,
        // 选中更新颜色
        color: isSelected ? Colors.orange : Colors.blue,
        alignment: Alignment.center,
        // 自动缩放文字，保证文字完整塞进盒子，不会溢出,适合单行文本
        child: FittedBox(
          // 文字自适应大小
          fit: BoxFit.scaleDown, // 文字太长才缩小；文字短就保持原生大小，**不会强行放大文字**（最常用）
          child: Text(name, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
