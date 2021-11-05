import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/extras/my_drawer.dart';
import 'package:flutter_learning/services/firebase/fb_messaging.dart';

import '../extras/custom_page_route.dart';
import 'animation/animated_container.dart';
import 'basic_for_android_devs/flutter_for_android.dart';
import 'database_screen/database_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FBMessaging.fbMessaging.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        theme: ThemeData(primaryColor: Colors.blue),
        home: const HomePage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'flutter_for_android':
              return MyPageRoute(
                  builder: (context) {
                    return FlutterForAndroid(title: "Flutter for Android");
                  },
                  settings: settings);

            case 'database':
              return MyPageRoute(
                  builder: (context) {
                    return DatabaseScreen(title: "Database");
                  },
                  settings: settings);

            case 'animated':
              return MyPageRoute(
                  builder: (context) {
                    return const AnimatedContainerScreen();
                  },
                  settings: settings);
          }
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FBMessaging.fbMessaging.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: const Center(child: Text("Home Page")),
        drawer: const MyDrawer());
  }
}
