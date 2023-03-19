import 'package:flutter/material.dart';

class DropField extends StatelessWidget {
  void Function(dynamic value) onChange;
  void Function(dynamic value) onClick;
  String hint;
  Icon icon;
  String type;
  dynamic value;
  List<dynamic> data;
  Color border_color;

  List<String> msg;
  bool enable;
  bool readonly = false;
  double radius;
  Color bkColor;
  bool lineType;
  bool isEmail;
  int maxline;
  Color bordercolor;
  DropField(
      {this.icon,
      @required this.hint,
      @required this.data,
      this.enable,
      this.type,
      this.msg,
      this.radius,
      this.border_color,
      this.bkColor,
      this.readonly,
      @required this.value,
      this.lineType = false,
      this.onChange,
      this.bordercolor});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: bkColor,
      menuMaxHeight: MediaQuery.of(context).size.height * 0.5,

      onChanged: (a) => onChange != null ? onChange(a) : null,
      value: value,
      items: data.map<DropdownMenuItem>((e) {
        return DropdownMenuItem(
          value: e,
          child: Container(
            child: Text(
              e,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        );
      }).toList(),

      // The validator receives the text that the user has entered.

      decoration: lineType
          ? InputDecoration(
              hintText: hint,
              prefixText: ' ',
              suffixStyle: const TextStyle(color: Colors.green),
            )
          : InputDecoration(
              hintStyle:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
              hintText: hint,
              fillColor: lineType
                  ? null
                  : bkColor != null
                      ? bkColor
                      : Theme.of(context).scaffoldBackgroundColor,
              prefixIcon: icon,
              filled: !lineType,
              suffixIcon: type == "pass" || type == "re_pass"
                  ? IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      color: icon.color,
                      onPressed: () {})
                  : null,
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 18,
                bottom: 8,
              ),
              enabledBorder: lineType
                  ? InputBorder.none
                  : OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(
                          color:
                              bordercolor != null ? bordercolor : Colors.white,
                          width: 0.5),
                      borderRadius:
                          BorderRadius.circular(radius != null ? radius : 3)),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(radius != null ? radius : 3)),
            ),

      validator: (value) {
        if (value.isEmpty) {
          return msg[0];
        } else if (!validate(value, type)) {
          return msg[1];
        }
        return null;
      },
    );
  }

  bool validate(String value, String type) {
    if (type == "text") {
      // RegExp exp= new RegExp(r'^(?=.*?[a-z])');
      var a = value.replaceAll(" ", "");
      var b = a.replaceAll("\n", "");
      var c = b.length > 2 ? true : false;

      bool matches = b == "" || !c ? false : true;

      return matches;
    } else if (type == "phone") {
      RegExp exp = RegExp(r'^[0-9]+$');
      bool matches = exp.hasMatch(value);

      return value.length > 10 && value.length < 13 ? matches : false;
    } else if (type == "number") {
      RegExp exp = RegExp(r'^[0-9]+$');
      bool matches = exp.hasMatch(value);

      return matches;
    } else if (type == "price") {
      RegExp exp = RegExp(r'^[0-9]+$');
      bool matches = exp.hasMatch(value);
      int p = 0;
      try {
        p = int.parse(value);
      } catch (e) {}
      return p < 999000000000 && p > 0 ? matches : false;
    } else if (type == "pass" || type == "re_pass") {
      // String  pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
      // RegExp regExp = new RegExp(pattern);
      // return regExp.hasMatch(value);

      return value.length > 7 ? true : false;
    } else if (type == "email") {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);

      return regex.hasMatch(value.replaceAll(" ", ""));
    } else if (type == "verf") {
      RegExp exp = RegExp(r'^[0-9]+$');
      bool matches = exp.hasMatch(value);

      return value.length == 6 ? matches : false;
    } else {
      return true;
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  datevailid(String value) {
    if (value?.isEmpty ?? true) {
      return 'Please fill filed';
    }
  }
}
