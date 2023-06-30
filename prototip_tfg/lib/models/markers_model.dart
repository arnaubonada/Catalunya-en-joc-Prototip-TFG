import 'dart:convert';

List<Markers> markersFromJson(String str) =>
    List<Markers>.from(json.decode(str).map((x) => Markers.fromJson(x)));

String markersToJson(List<Markers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Markers {
  String id;
  double lat;
  double lng;
  String place;
  String img;
  String info;
  bool rewarded;
  int counter;

  Markers(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.place,
      required this.img,
      required this.info,
      this.rewarded = false,
      this.counter = 0});

  factory Markers.fromJson(Map<String, dynamic> json) => Markers(
        id: json["id"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        place: json["place"],
        img: json["img"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "place": place,
        "img": img,
        "info": info,
      };
}
