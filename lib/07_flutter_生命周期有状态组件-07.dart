import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

// 创建日志器
final log = Logger();

// ==== 有状态组件创建阶段 createState-initState-didChangeDependencies-build
// ==== 更新阶段 didUpdateWidget-build
// ==== 销毁阶段 deactivate-dispose
// ==== 仅执行一次函数 createState initState dispose
// ==== inheritedWidget 专门用于在widget树中自顶向下高效的共享数据，顶层组件提供数据，子孙节点直接获取
class MainPage extends StatefulWidget {
  // const MainPage({super.key});
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {

  // - 初始化 `TextEditingController`、`AnimationController`
  // - 注册 stream / ChangeNotifier 监听
  // - 使用 `widget.xxx` 给 state 成员变量赋值（构造函数拿不到`widget`）
  // - 只执行一次的业务逻辑
  @override
  void initState() {
    // TODO: implement initState
    log.d("==============initState=============");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log.d("==============build方法=============");
    return const Placeholder();
  }
}
