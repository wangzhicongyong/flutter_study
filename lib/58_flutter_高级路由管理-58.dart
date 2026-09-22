// 路由的管理和使用场景需要根据具体的业务来判断，实际是控制路由站

import 'package:flutter/material.dart';

// 1.具体业务：目前淘宝的网页是 点击进入，可以看到商品列表，点击进入店铺详情页，需要验证你是否登录
// 2.如果没有登录，则跳转到登录页面

void main(List<String> args) {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 路由的匹配优先是去路由表里匹配路由
    return MaterialApp(
      initialRoute: "/goodsList",
      routes: {"/goodsList": (context) => GoodsList()},
      // 匹配不到则找它 会优先调用
      // 优先级：`onGenerateRoute` > 写死的 `routes` 静态路由表
      onGenerateRoute: (settings) {
        if (settings.name == "/cartList") {
          debugPrint(settings.name);
          // ======================================这种写法是 onGenerateRoute的独有写法================================================
          return MaterialPageRoute(builder: (context) => CartList(), settings: settings);
        }
      },
    );
  }
}

// 商品列表
class GoodsList extends StatefulWidget {
  const GoodsList({super.key});

  @override
  State<GoodsList> createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品列表"), centerTitle: true),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/cartList", arguments: {"id":"1"});
          },
          child: Text("加入购物车"),
        ),
      ),
    );
  }
}

// 购物车列表
class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("购物车列表"), centerTitle: true),
      body: Center(
        child: TextButton(onPressed: () {
          Navigator.pushNamed(context, "/LoginPage", arguments: {"id":"1"});
        }, child: Text("去支付")),
      ),
    );
  }
}

// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录页面"), centerTitle: true),
      body: Center(
        child: TextButton(onPressed: () {
          Navigator.pushNamed(context, "/LoginPage", arguments: {"id":"1"});
        }, child: Text("去登录")),
      ),
    );
  }
}
