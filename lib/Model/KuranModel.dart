class KuranModel {
  List<Suar> suar;

  KuranModel({this.suar});

  KuranModel.fromJson(Map<String, dynamic> json) {
    if (json['suar'] != null) {
      suar = new List<Suar>();
      json['suar'].forEach((v) {
        suar.add(new Suar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suar != null) {
      data['suar'] = this.suar.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suar {
  String name;
  String number;
  List<String> ayat;

  Suar({this.name, this.number, this.ayat});

  Suar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    ayat = json['ayat'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['ayat'] = this.ayat;
    return data;
  }
}
