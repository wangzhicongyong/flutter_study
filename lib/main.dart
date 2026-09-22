import 'package:flutter/material.dart';

// title 用来展示窗口的标题内容
// theme 用来设置整个应用的主题
// home 用来展示窗口的主体内容

void main() {
  // myapp（）是widget对象
  runApp(const MyApp());
}

// StatelessWidget 是无状态组件 没有state对象  没有setState（）方法 所有属性必须是 final, UI 完全靠构造函数传入参数决定
class MyApp extends StatelessWidget {
  // const 开启常量性能优化 如果组件参数不变，复用同一个对象实例；父组件重建时，该Widget不会重复创建，优化性能
  // MyApp的构造函数 简写
  // const MyApp(Key? key):super(key:key)  Widget 基类需要`key`，用于在 组件树 识别组件节点，做 diff 更新、状态保留
  const MyApp({super.key});  
  // const MyApp(Key? key):super(key:key)  

  // This widget is the root of your application.
  // build 只写 UI 组装代码，不要写业务逻辑、网络请求、定时器、弹窗
  // 重写build方法，返回一个组件对象
  // build 方法会反复执行
  @override
  Widget build(BuildContext context) {
    // Theme.of(context).colorScheme.primary;
    // **MaterialApp**：**根**，全局，管主题、路由。整个 APP 只写一次
    return MaterialApp(
      title: 'Flutter 演示',   // 任务窗口主题 浏览器打开的页面标签
      debugShowCheckedModeBanner: false, // 关闭右上角debug标签
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.red.shade200),
      ),
      themeMode: ThemeMode.system, // system跟随系统 light浅色 dark深色
      // 指定主页 默认首页
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 创建myhomePage类 有状态组件  有state对象 setState（）方法 主页类
class MyHomePage extends StatefulWidget {
  // 此处调用 myhomepage 是同一个实列对象
  // final 成员用初始化列表初始化 也是可以进行无参构造
  final String title; 
  // 可空类型，不给默认值也可以省略 也是可以xxx（）直接实列化对象的
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  // 泛型  此处是重写父类的方法
  // state 是一个状态对象<>里面表示该状态是与谁绑定的
  // 需要修改状态时，在该类中进行编写
  @override
  State<MyHomePage> createState() => _MyHomePageState();  // 语法 函数名()=>代码逻辑
}

// 私有类 只能在当前库文件访问，无法import  为什么是私有类  因为该类是 主页专门使用类 仅在此库使用
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // 应用栏
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // 居中
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
