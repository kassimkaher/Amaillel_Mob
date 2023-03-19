class TopModel {
  List<DataSlide> dataSlide;

  TopModel({this.dataSlide});

  TopModel.fromJson(Map<String, dynamic> json) {
    if (json['data_slide'] != null) {
      dataSlide = new List<DataSlide>();
      json['data_slide'].forEach((v) {
        dataSlide.add(new DataSlide.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataSlide != null) {
      data['data_slide'] = this.dataSlide.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSlide {
  int id;
  String imageUrl;
  String title;

  DataSlide({this.id, this.imageUrl, this.title});

  DataSlide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    return data;
  }
}
