class TourLocationsResponse {
  String? id;
  double? latitude;
  double? longitude;

  TourLocationsResponse({this.id, this.latitude, this.longitude});

  TourLocationsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
