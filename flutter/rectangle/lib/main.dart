import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures and Animations',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongPress = 0;

  double posX = 0.0;
  double posY = 0.0;
  double boxWidth = 0.0;
  double boxHeight = 0.0;
  final double fullBoxWidth = 150.0;
  final double fullBoxHeight = 75.0;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    animation.addListener(() {
      setState(() {
        boxWidth = fullBoxWidth * animation.value;
        boxHeight = fullBoxHeight * animation.value;
      });

      center(context);
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    if (posX == 0) {
      center(context);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Gestures and Animations")),
      body: GestureDetector(
          onTap: () {
            setState(() {
              numTaps++;
            });
          },
          onDoubleTap: () {
            setState(() {
              numDoubleTaps++;
            });
          },
          onLongPress: () {
            setState(() {
              numLongPress++;
            });
          },
          onVerticalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double delta = value.delta.dy;
              posY += delta;
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double delta = value.delta.dx;
              posX += delta;
            });
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: posX,
                  top: posY,
                  child: Container(
                    width: boxWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(color: Colors.red),
                  ))
            ],
          )),
      bottomNavigationBar: Material(
          color: Theme.of(context).primaryColorLight,
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Taps: $numTaps - Double Taps: $numDoubleTaps - Long Presses: $numLongPress",
                style: Theme.of(context).textTheme.headline6,
              ))),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxWidth / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxHeight / 2 - 30.0;

    setState(() {
      posX = posX;
      posY = posY;
    });
  }
}
