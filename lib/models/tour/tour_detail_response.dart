class TourDetailResponse {
  int? babyPrice;
  int? childrenPrice;
  String? code;
  String? departure;
  String? description;
  String? destination;
  String? endTime;
  String? id;
  int? maxOccupancy;
  int? price;
  String? startTime;
  String? thumbnailUrl;
  String? title;
  String? type;
  Null vehicle;
  String? status;

  TourDetailResponse(
      {this.babyPrice,
      this.childrenPrice,
      this.code,
      this.departure,
      this.description,
      this.destination,
      this.endTime,
      this.id,
      this.maxOccupancy,
      this.price,
      this.startTime,
      this.thumbnailUrl,
      this.title,
      this.type,
      this.vehicle,
      this.status});

  TourDetailResponse.fromJson(Map<String, dynamic> json) {
    babyPrice = json['babyPrice'];
    childrenPrice = json['childrenPrice'];
    code = json['code'];
    departure = json['departure'];
    description = json['description'];
    destination = json['destination'];
    endTime = json['endTime'];
    id = json['id'];
    maxOccupancy = json['maxOccupancy'];
    price = json['price'];
    startTime = json['startTime'];
    thumbnailUrl = json['thumbnailUrl'];
    title = json['title'];
    type = json['type'];
    vehicle = json['vehicle'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['babyPrice'] = this.babyPrice;
    data['childrenPrice'] = this.childrenPrice;
    data['code'] = this.code;
    data['departure'] = this.departure;
    data['description'] = this.description;
    data['destination'] = this.destination;
    data['endTime'] = this.endTime;
    data['id'] = this.id;
    data['maxOccupancy'] = this.maxOccupancy;
    data['price'] = this.price;
    data['startTime'] = this.startTime;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['title'] = this.title;
    data['type'] = this.type;
    data['vehicle'] = this.vehicle;
    data['status'] = this.status;
    return data;
  }
}
