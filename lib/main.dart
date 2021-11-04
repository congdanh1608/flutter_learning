import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/database_screen/database_screen.dart';
import 'package:flutter_learning/services/firebase/fb_messaging.dart';

import 'flutter_for_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FBMessaging.fbMessaging.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "My App", theme: ThemeData(primaryColor: Colors.red), home: const HomePage(), routes: <String, WidgetBuilder>{
      'flutter_for_android': (BuildContext context) => FlutterForAndroid(title: "Flutter for Android"),
      'database': (BuildContext context) => DatabaseScreen(title: "Database")
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'flutter_for_android',
                    );
                  },
                  child: const Text("Flutter for Android devs")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'database',
                    );
                  },
                  child: const Text("Database")),
            ],
          ),
        ));
  }
}
