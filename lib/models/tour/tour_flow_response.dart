class TourFlowResponse {
  String? id;
  double? longitude;
  double? latitude;
  String? arrivalTime;
  String? description;

  TourFlowResponse(
      {this.id,
      this.longitude,
      this.latitude,
      this.arrivalTime,
      this.description});

  TourFlowResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    arrivalTime = json['arrivalTime'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['arrivalTime'] = this.arrivalTime;
    data['description'] = this.description;
    return data;
  }
}
