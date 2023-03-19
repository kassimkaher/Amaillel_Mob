class AmmalModel {
  List<DataAmal> dataAmal;

  AmmalModel({this.dataAmal});

  AmmalModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data_amal'] != null) {
      dataAmal = new List<DataAmal>();
      json['data_amal'].forEach((v) {
        dataAmal.add(new DataAmal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataAmal != null) {
      data['data_amal'] = this.dataAmal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAmal {
  String id;
  String title;
  String desc;
  int month;
  int day;
  String monthName;
  List<ItemsAmal> itemsAmal;

  DataAmal(
      {
        this.id,
        this.title,
      this.desc,
      this.month,
      this.day,
      this.monthName,
      this.itemsAmal});

  DataAmal.fromJson(Map<dynamic, dynamic> json) {
     id = json['id'];
    title = json['title'];
    desc = json['desc'];
    month = json['month'];
    day = json['day'];
    monthName = json['month_name'];
    
    if (json['items_amal'] != null) {

      itemsAmal = new List<ItemsAmal>();
      json['items_amal'].forEach((v) {
        itemsAmal.add(new ItemsAmal.fromJson(v));
      });
    }else{

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['month'] = this.month;
    data['day'] = this.day;
    data['month_name'] = this.monthName;
     data['id'] = this.id;

    if (this.itemsAmal != null) {

      data['items_amal'] = this.itemsAmal.map((v) => v.toJson()).toList();
    }else{
      data['items_amal']=null;
      
    }
    return data;
  }
}

class ItemsAmal {
  String name;
  String desc;
  int link;
  List<String> images;

  ItemsAmal({this.name, this.desc, this.link, this.images});

  ItemsAmal.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    link = json['link'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['link'] = this.link;
    data['images'] = this.images;
    return data;
  }
}
