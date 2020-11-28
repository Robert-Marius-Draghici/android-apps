import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          text("University Courses", Colors.yellow, 'PTSerif', 50.0,
              FontWeight.w400),
          Row(
            children: <Widget>[
              Expanded(
                  child: text("Subject", Colors.deepOrange, 'PTSerif', 30.0,
                      FontWeight.w500)),
              Expanded(
                  child: text("Teacher", Colors.deepOrange, 'PTSerif', 30.0,
                      FontWeight.w500)),
            ],
          ),
          Row(children: <Widget>[
            Expanded(
                child: text(
                    "Physics", Colors.amber, 'PTSerif', 30.0, FontWeight.w300)),
            Expanded(
                child: text("Archimedes", Colors.amber, 'PTSerif', 30.0,
                    FontWeight.w300)),
          ]),
          Row(children: <Widget>[
            Expanded(
                child: text("Geometry", Colors.amber, 'PTSerif', 30.0,
                    FontWeight.w300)),
            Expanded(
                child: text(
                    "Euclid", Colors.amber, 'PTSerif', 30.0, FontWeight.w300)),
          ]),
          Row(children: <Widget>[
            Expanded(
                child: text(
                    "History", Colors.amber, 'PTSerif', 30.0, FontWeight.w300)),
            Expanded(
                child: text("Herodotus", Colors.amber, 'PTSerif', 30.0,
                    FontWeight.w300)),
          ]),
          Row(children: <Widget>[
            Expanded(
                child: text(
                    "Biology", Colors.amber, 'PTSerif', 30.0, FontWeight.w300)),
            Expanded(
                child: text("Hippocrates", Colors.amber, 'PTSerif', 30.0,
                    FontWeight.w300)),
          ]),
          Row(
            children: <Widget>[
              Image(
                image: AssetImage('images/university.png'),
                width: 200.0,
                height: 200.0,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Accept courses"),
                color: Colors.lime,
                elevation: 5.0,
                onPressed: () {
                  onPressed(context);
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
      color: Colors.teal,
      padding: EdgeInsets.all(10.0),
    );
  }

  Widget text(String data, MaterialColor color, String fontFamily,
      double fontSize, FontWeight fontWeight) {
    return Text(data,
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ));
  }

  void onPressed(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Accept courses"),
      content: Text("Courses accepted."),
    );
    showDialog(context: context, builder: (BuildContext) => alert);
  }
}
