class RecordsModel {
  int? id;
  String? name;
  String? phone;
  String? city;
  String? image;
  int? rupee;

  RecordsModel({this.id,this.name, this.phone, this.city, this.image, this.rupee});

  RecordsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    image = json['profile_image'];
    rupee = json['rupee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['city'] = city;
    data['profile_image'] = image;
    data['rupee'] = rupee;
    return data;
  }
}
