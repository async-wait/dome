import 'package:flutter/material.dart';

class Birthday extends StatefulWidget {
  @override
  BirthdayState createState() => BirthdayState();
}

class BirthdayState extends State<Birthday> {
  String _birthday = '2019-10-22';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生日选择')
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text('我的生日是：' + _birthday),
          ),
          RaisedButton(
            child: Text("点击选择生日"),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: 290,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/icon-birthday@2x.png'),
                                width: 20,
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text('生日', style: TextStyle(color: Color(0xff2F3643), fontSize: 17)),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('month'),
                                  Text('day')
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffF06E23),
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(255, 161, 124, 0.52),
                                  offset: Offset(0,10),
                                  blurRadius: 15
                                )
                              ]
                            ),
                            child: FlatButton(
                              child: Text('确定', style: TextStyle(color: Colors.white, fontSize: 17),), 
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    );
                  },
              );
            },
          )
        ],
      )
    );
  }
}