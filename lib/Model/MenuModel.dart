import 'package:flutter/material.dart';

class MenuModel {
  String title;
  String subtitle;
  String im;
  int page;
  Color color;

  MenuModel({this.title, this.subtitle, this.im, this.page, this.color});

  MenuModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    im = json['im'];
    page = json['page'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['im'] = this.im;
    data['page'] = this.page;
    data['color'] = this.color;
    return data;
  }
}
