class PagodaOb {
  String? id;
  String? name;
  double? lat;
  double? log;
  String? about;
  List<String>? image;
  String? location;

  PagodaOb(
      {this.id,
      this.name,
      this.lat,
      this.log,
      this.about,
      this.image,
      this.location});

  PagodaOb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    log = json['log'];
    about = json['about'];
    image = json['image'].cast<String>();
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['log'] = this.log;
    data['about'] = this.about;
    data['image'] = this.image;
    data['location'] = this.location;
    return data;
  }
}
