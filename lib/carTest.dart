import 'package:flutter/material.dart';

class CarTest extends StatefulWidget {
  @override
  CarTestState createState() => CarTestState();
}

class CarTestState extends State<CarTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('车辆检测')
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.orange, 
            child: Image(
              image: AssetImage('assets/images/car.gif'),
              width: 400,
            ),
          )
        ],
      )
    );
  }
}