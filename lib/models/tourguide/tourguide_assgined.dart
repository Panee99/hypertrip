class TourGuideAssigned {
  String? id;
  String? code;
  int? maxOccupancy;
  String? title;
  String? departure;
  String? destination;
  String? startTime;
  String? endTime;
  double? adultPrice;
  double? childrenPrice;
  double? infantPrice;
  String? thumbnailUrl;
  String? description;
  String? type;
  String? status;

  TourGuideAssigned(
      {this.id,
      this.code,
      this.maxOccupancy,
      this.title,
      this.departure,
      this.destination,
      this.startTime,
      this.endTime,
      this.adultPrice,
      this.childrenPrice,
      this.infantPrice,
      this.thumbnailUrl,
      this.description,
      this.type,
      this.status});

  TourGuideAssigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    maxOccupancy = json['maxOccupancy'];
    title = json['title'];
    departure = json['departure'];
    destination = json['destination'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    adultPrice = json['adultPrice'];
    childrenPrice = json['childrenPrice'];
    infantPrice = json['infantPrice'];
    thumbnailUrl = json['thumbnailUrl'];
    description = json['description'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['maxOccupancy'] = this.maxOccupancy;
    data['title'] = this.title;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['adultPrice'] = this.adultPrice;
    data['childrenPrice'] = this.childrenPrice;
    data['infantPrice'] = this.infantPrice;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['description'] = this.description;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
