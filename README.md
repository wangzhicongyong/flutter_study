# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<!-- // 创建flutter项目工程 -->
# 1.可以先创建一个项目文件夹，用vscode打开该项目文件夹
# 2.然后在vscode的终端上执行命令：flutter create --platforms web(具体的设备平台) 项目名称
# 3.创建成功发之后，该项目工程就是在项目文件夹里面，然后再用vscode打开
# 4.方法二：在vscode命令行面板里面搜索flutte：create project命令也是可以创建flutetr项目工程


# 当类的成员属性为可空的时候，是可以进行无参构造函数的,实列化对象也很方便
# Dart 插件自带 `stful` / `stless` 可以自动补全

# 安装依赖 flutter pub add dio 如果依赖没有显示在依赖文件 则继续执行 flutter pub get 拉取依赖 必须是在项目文件夹
# =====切记千万别在vscode上更新flutter flutter upgrade  很可能会破坏flutter文件
# =====如果是需要让vscode和自己的github连接上，vscode内置了github，可以先终端查看版本 git --version
# =====同时在vscode上安裝插件：GitHub Pull Requests
# =====================配置git的用户名和邮箱，以后在更新和提交上会显示出来==================
# git config --global user.name "kaili"
# git config --global user.email "784571621@qq.com"
# 如何把自己的代码上传到github上
1. 登录 [github.com](https://github.com) → 右上角头像 `New repository`
2. 填写仓库名称（比如 flutter_go_router_demo）
3. Description 随便写，**不要勾选 Add a README、.gitignore、license**（本地已经有代码，勾选会冲突）
4. 选 Public / Private，点 Create repository
5. 创建完成页面会给仓库地址，复制 HTTPS 链接：`https://github.com/你的用户名/仓库名.git`
6. 必须打开**项目根目录**（包含 pubspec.yaml 的那一层）
7. 然后在终端进行github初始化：git init
8. 点击左侧的github图标，可以进行可视化操作，等同于命令：
    git add .
    git commit -m "提示信息"
9. 最后进行远程连接github：git remote add origin https://github.com/wangzhicongyong/flutter_study.git
10. # 4. 将当前本地分支重命名为 main   使用命令：git branch -M main
11. # 5. 推送并绑定远程main分支        使用命令：git push -u origin main
# =====================================================================
# 如果推送有问题，可以使用git remote -v 检查远程仓库是否绑定成功
# 我无法提交成功，是因为我在创建新的仓库的时候，你在 GitHub 网页新建仓库的时候，如果勾选了 `Add a README file` / `.gitignore`，
    GitHub 会自动在远程 main 分支生成一次提交，而自己的本地项目也已经git初始化过，有自己的readme，。gitignoore文件发生冲突，阻止覆盖，
    所以提交失败。
    解决方案：
    # 拉取远程main，允许合并两个没有关联的git历史
    git pull origin main --allow-unrelated-histories
    # 拉取完成后，再推送
    git push -u origin main
    # 检查分之
    git checkout 
