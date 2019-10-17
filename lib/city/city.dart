import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';
import 'city_model.dart';
import './cityInfo.dart';

class CityList extends StatefulWidget {
  Map<String, String> checkedCity;
  CityList(this.checkedCity);

  @override
  State<StatefulWidget> createState() {
    return new _CityListState();
  }
}

class _CityListState extends State<CityList> {
  List<CityInfo> _cityList = List();
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  Map<String, String> _cityInfo = Map();

  @override
  void initState() {
    super.initState();
    loadData();
    if (widget.checkedCity != null && widget.checkedCity['name'] != null) {
      _cityInfo = widget.checkedCity;
    } else {
      _cityInfo = {"name": "北京市", "id": "110100"};
    }
  }

  void loadData() async {
    //加载城市列表
    cityInfo.forEach((item) {
      item['cities'].forEach((value) {
        _cityList.add(CityInfo(name: value['name'], id: value['id']));
      });
    });
    _handleList(_cityList);
  }

  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    // susTag = (susTag == "★" ? "热门城市" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(CityInfo model) {
    String susTag = model.getSuspensionTag();
    // susTag = (susTag == "★" ? "热门城市" : susTag);
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              setState(() {
                _cityInfo['name'] = model.name;
                _cityInfo['id'] = model.id;
              });
              // Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择城市', style: TextStyle(color: Colors.black, fontSize: 17),),
        centerTitle: true,
        elevation: 4.0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context, _cityInfo);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15.0, top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '当前城市',
                      style: TextStyle(fontSize: 17, color: Color(0xff9FA5BB)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 13, bottom: 22),
                    child: Container(
                      padding: EdgeInsets.only(top: 8, right: 15, bottom: 8, left: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffE6E8EC),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/event_ico_map_location@2x.png'),
                            width: 10,
                            height: 14,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              _cityInfo['name'],
                              style: TextStyle(fontSize: 14, color: Color(0xff2F3643)),
                            ),
                          )
                        ],
                      )
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: AzListView(
                data: _cityList,
                // topData: _hotCityList,
                itemBuilder: (context, model) => _buildListItem(model),
                suspensionWidget: _buildSusWidget(_suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: _onSusTagChanged,
                //showCenterTip: false,
              )),
        ],
      ),
    );
  }
}
