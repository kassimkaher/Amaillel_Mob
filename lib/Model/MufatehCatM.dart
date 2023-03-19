class MufatehCatModel {
  List<Datac> datac;

  MufatehCatModel({this.datac});

  MufatehCatModel.fromJson(Map<String, dynamic> json) {
    if (json['datac'] != null) {
      datac = new List<Datac>();
      json['datac'].forEach((v) {
        datac.add(new Datac.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datac != null) {
      data['datac'] = this.datac.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datac {
  int id;
  String title;
  String url;
  String content;

  Datac({this.id, this.title, this.url, this.content});

  Datac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['content'] = "";
    return data;
  }
}
