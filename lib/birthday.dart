import 'package:flutter/material.dart';
import './datePicker/widget/date_picker_widget.dart';
class  SelectBirthday {
  static Future show(context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return DatePickerWidget();
      }
    );
  }
}