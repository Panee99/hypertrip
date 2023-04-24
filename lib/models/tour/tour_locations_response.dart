class TourLocationsResponse {
  String? id;
  double? latitude;
  double? longitude;
  String? vehicle;
  String? arrivalTime;

  TourLocationsResponse(
      {this.id, this.latitude, this.longitude, this.vehicle, this.arrivalTime});

  TourLocationsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    vehicle = json['vehicle'];
    arrivalTime = json['arrivalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['vehicle'] = this.vehicle;
    data['arrivalTime'] = this.arrivalTime;
    return data;
  }
}
