import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './city/city.dart';
import 'carTest.dart';
import 'birthday.dart';
// import './date_picker_bottom_sheet.dart';
import './datePicker/widget/date_picker_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  Map<String, String> checkedCity = {
    "name": "南京市",
    "id": "320100"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("城市列表"),
              onPressed: () {
                Navigator.push( context,
                  MaterialPageRoute(builder: (context) {
                      return CityList(checkedCity);
                  })
                ).then((value) {
                  print(value);
                });
              },
            ),
            RaisedButton(
              child: Text("体检动画"),
              onPressed: () {
                Navigator.push( context,
                  MaterialPageRoute(builder: (context) {
                      return CarTest();
                  })
                );
              },
            ),
            RaisedButton(
              child: Text("生日选择"),
              onPressed: () {
                SelectBirthday.show(context).then((value) {
                  print(value);
                });
              },
            ),
            RaisedButton(
              child: Text("dome"),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext builder) {
                    return DatePickerWidget();
                  }
                );
              },
            )
          ],
        )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
