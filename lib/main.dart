import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  // Test case 1 was to simply call ensureInitialized and observe Metal errors.
  // It seems they do not appear in this project, though.
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Headline 123',
              style: Theme.of(context).textTheme.headline5,
            ),
            SvgPicture.asset(
              'assets/icons/tiger.usvg.svg',
              height: 250,
              fit: BoxFit.contain,
            ),
            // Test case 2: Here things start to break. 
            // If this line is uncommented, the metal errors will show.
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
