import 'package:azlistview/azlistview.dart';

class CityInfo extends ISuspensionBean {
  String name;
  String id;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.id
  });
  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'],
      id = json['id'] == null ? "" : json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
        'id': id
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() {
    return "CityBean {" + " \"name\":\"" + name + "\"," + " \"id\":\"" + id + "\"" + '}';
  }
}
