import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: (settings) {
        if (settings.name == '/cupertinoPageRoute') {
          // use CupertinoPageRoute
          return CupertinoPageRoute(
            settings: settings,
            builder: (_) => SecondaryPage(),
          );
        }
        if (settings.name == '/pageRouteBuilder') {
          // use PageRouteBuilder
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SecondaryPage(),
          );
        }
        // defaults to use the MaterialPageRoute
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SecondaryPage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Navigate using popAndPushNamed'),
            ElevatedButton(
              onPressed: () => _popAndPushNamedRoute('/materialPageRoute'),
              child: Text('popAndPushNamed with MaterialPageRoute'),
            ),
            ElevatedButton(
              onPressed: () => _popAndPushNamedRoute('/cupertinoPageRoute'),
              child: Text('popAndPushNamed with CupertinoPageRoute'),
            ),
            ElevatedButton(
              onPressed: () => _popAndPushNamedRoute('/pageRouteBuilder'),
              child: Text('popAndPushNamed with PageRouteBuilder'),
            ),
            Text(
              'Note: Perform a hot restart to test the other cases,\nsince we navigate using popAndPush',
            ),
          ],
        ),
      ),
    );
  }

  /// Pops and pushes a named route.
  void _popAndPushNamedRoute(String routeName) {
    Navigator.popAndPushNamed(
      context,
      routeName,
      arguments: {'routeName': routeName},
    );
  }
}

class SecondaryPage extends StatefulWidget {
  @override
  _SecondaryPageState createState() => _SecondaryPageState();
}

class _SecondaryPageState extends State<SecondaryPage> {
  final _logoKey = GlobalKey();
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = _logoKey.currentContext.findRenderObject();
      setState(() {
        // calculate offset in global coordinate system and center this offset.
        _offset = box.localToGlobal(box.size.center(Offset.zero));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map pageRoute = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${pageRoute['routeName']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(key: _logoKey, size: 100.0),
            Text(_offset.toString()),
          ],
        ),
      ),
    );
  }
}
