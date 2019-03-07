import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_learning/images/image_loading.dart';
import 'package:flutter_learning/views/animation/fade_in_out.dart';
import 'package:flutter_learning/views/design/add_drawer.dart';
import 'package:flutter_learning/views/design/fonts.dart';
import 'package:flutter_learning/views/design/orientation_list.dart';
import 'package:flutter_learning/views/design/snackBar.dart';
import 'package:flutter_learning/views/design/tabs.dart';
import 'package:flutter_learning/views/forms/custom_form.dart';
import 'package:flutter_learning/views/forms/text_field.dart';
import 'package:flutter_learning/views/gestures/inkwell.dart';
import 'package:flutter_learning/views/gestures/swipe.dart';
import 'package:flutter_learning/views/lists/basic_list.dart';
import 'package:flutter_learning/views/lists/grid_list.dart';
import 'package:flutter_learning/views/lists/horizontal_list.dart';
import 'package:flutter_learning/views/lists/mylist.dart';
import 'package:flutter_learning/views/lists/sliver_app_bar.dart';
import 'package:flutter_learning/views/lists/type_item_list.dart';
import 'package:flutter_learning/views/main/header_item.dart';
import 'package:flutter_learning/views/main/item.dart';
import 'package:flutter_learning/views/main/main_list_item.dart';
import 'package:flutter_learning/views/navigation/hero_animation.dart';
import 'package:flutter_learning/views/navigation/route_navigation.dart';
import 'package:sentry/sentry.dart';

/*region for maintenance*/
void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Reporting to Firebase Crashlytics...');
  FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);

  print('Reporting to Sentry.io...');
  final SentryClient _sentry = new SentryClient(dsn: "https://8f9f84a2da7f497ca203e50918edb1e4:1798dd9b44c746cab02b8ef4476ada60@sentry.io/1407929");
  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}
/*end region for maintenance*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Cookbook(),
        '/nextScreen': (context) => MyNextRouteNavigation(),
      },
      onGenerateRoute: _getRoute,
      //if there is route define on MaterialApp() => don't need to define home here.
      /*home: Cookbook(),*/
      //Another way use OnGenerateRoute with pushNamed
      //https://stackoverflow.com/questions/53304340/navigator-pass-arguments-with-pushnamed/54770709#54770709
      title: "Cookbook",
      theme: new ThemeData(
          primaryColor: Colors.lightBlue[500],
          brightness: Brightness.dark,
          accentColor: Colors.cyan,
          fontFamily: 'Raleway',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 28.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 16.0, fontFamily: 'TrajanPro'),
            body2: TextStyle(fontSize: 12.0, fontFamily: 'TrajanPro'),
          )),
    );
  }

  Route<dynamic> _getRoute(routeSettings) {
    switch (routeSettings.name) {
      case '/nextScreen':
        print('NextScreen');
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => MyNextRouteNavigation(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => Cookbook(),
        );
    }
  }
}

class Cookbook extends StatefulWidget {
  final List<MainListItem> items = new List();

  @override
  State<StatefulWidget> createState() {
    //generate the data
    _generateData();

    //main view
    return new CookbookState(items);
  }

  void _generateData() {
    items.add(new HeaderItem("Animation", Colors.cyan));
    items.add(new Item("Fade a Widget in and out", 0));

    items.add(new HeaderItem("Design", Colors.yellow));
    items.add(new Item("Add a Drawer to a screen", 1));
    items.add(new Item("Displaying SnackBars", 2));
    items.add(new Item("Exporting fonts from a package", 3));
    items.add(new Item("Updating the UI based on orientation", 4));
    items.add(new Item("Working with Tabs", 5));

    items.add(new HeaderItem("Forms", Colors.red));
    items.add(new Item("Building a form with validation", 6));
    items.add(new Item("Create, style and focus a text field", 7));

    items.add(new HeaderItem("Gestures", Colors.deepOrange));
    items.add(new Item("Adding Material Touch Ripples", 8));
    items.add(new Item("Implement Swipe to Dismiss", 9));

    items.add(new HeaderItem("Images", Colors.greenAccent));
    items.add(new Item("Display images", 10));

    items.add(new HeaderItem("Lists", Colors.lightGreen));
    items.add(new Item("Basic List", 11));
    items.add(new Item("Horizontal List", 12));
    items.add(new Item("Grid List", 13));
    items.add(new Item("Lists with different types of items", 14));
    items.add(new Item("Place a floating app bar above a list", 15));
    items.add(new Item("Random Words", 16));

    items.add(new HeaderItem("Navigation", Colors.purple));
    items.add(new Item("Animating a Widget across screens", 17));
    items.add(new Item("Navigate with named routes", 18));
  }
}

class CookbookState extends State<Cookbook> {
  final List<MainListItem> items;

  CookbookState(this.items);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cookbook"),
      ),
      body: _buildCookbookContent(),
    );
  }

  Widget _buildCookbookContent() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return _buildRows(i);
        });
  }

  _buildRows(int index) {
    MainListItem item = items[index];

    if (item is HeaderItem) {
      return new ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 18.0,
            color: item.color,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else if (item is Item) {
      return new ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        trailing: new Icon(Icons.navigate_next),
        onTap: () {
          _onItemTap(item.type);
        },
      );
    }
  }

  void _onItemTap(int type) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: isShowAppBar(type)
            ? new AppBar(
                title: new Text(getTitle(type)),
              )
            : null,
        body: getView(type),
      );
    }));
  }

  //is show the app bar with type page?
  isShowAppBar(int type) {
    List<int> noAppBarPages = new List();
    noAppBarPages.add(15);
    if (noAppBarPages.contains(type)) return false;
    return true;
  }

  //get title of type page
  getTitle(int type) {
    for (var item in items) {
      if (item.type == type) {
        return item.title;
      }
    }
    return "";
  }

  //get view of type page
  getView(int type) {
    switch (type) {
      case 0:
        return FadeInOut();
      case 1:
        return MyAddDrawer();
      case 2:
        return MySnackBar();
      case 3:
        return MyFonts();
      case 4:
        return OrientationList();
      case 5:
        return MyTabBar();
      case 6:
        return MyCustomForm();
      case 7:
        return MyTextField();
      case 8:
        return MyInkWell();
      case 9:
        return MySwipe();
      case 10:
        return MyImage();
      case 11:
        return BasicList();
      case 12:
        return HorizontalList();
      case 13:
        return GridList();
      case 14:
        return MyTypeList();
      case 15:
        return MySliverAppBar();
      case 16:
        return RandomWords();
      case 17:
        return MyHeroAnimation();
      case 18:
        return MyRouteNavigation();
    }
  }
}
