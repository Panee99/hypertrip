class CurrentGroupResponse {
  String? id;
  String? createdAt;
  String? groupName;
  String? tourGuideId;
  int? maxOccupancy;
  String? tourVariantId;
  TourVariant? tourVariant;

  CurrentGroupResponse(
      {this.id,
      this.createdAt,
      this.groupName,
      this.tourGuideId,
      this.maxOccupancy,
      this.tourVariantId,
      this.tourVariant});

  CurrentGroupResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    groupName = json['groupName'];
    tourGuideId = json['tourGuideId'];
    maxOccupancy = json['maxOccupancy'];
    tourVariantId = json['tourVariantId'];
    tourVariant = json['tourVariant'] != null
        ? new TourVariant.fromJson(json['tourVariant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['groupName'] = this.groupName;
    data['tourGuideId'] = this.tourGuideId;
    data['maxOccupancy'] = this.maxOccupancy;
    data['tourVariantId'] = this.tourVariantId;
    if (this.tourVariant != null) {
      data['tourVariant'] = this.tourVariant!.toJson();
    }
    return data;
  }
}

class TourVariant {
  String? id;
  String? code;
  int? adultPrice;
  int? childrenPrice;
  int? infantPrice;
  String? startTime;
  String? endTime;
  String? status;
  String? tourId;
  Tour? tour;

  TourVariant(
      {this.id,
      this.code,
      this.adultPrice,
      this.childrenPrice,
      this.infantPrice,
      this.startTime,
      this.endTime,
      this.status,
      this.tourId,
      this.tour});

  TourVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    adultPrice = json['adultPrice'];
    childrenPrice = json['childrenPrice'];
    infantPrice = json['infantPrice'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    tourId = json['tourId'];
    tour = json['tour'] != null ? new Tour.fromJson(json['tour']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['adultPrice'] = this.adultPrice;
    data['childrenPrice'] = this.childrenPrice;
    data['infantPrice'] = this.infantPrice;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['tourId'] = this.tourId;
    if (this.tour != null) {
      data['tour'] = this.tour!.toJson();
    }
    return data;
  }
}

class Tour {
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? description;
  Null? policy;
  String? thumbnailUrl;
  int? maxOccupancy;
  String? type;
  String? status;

  Tour(
      {this.id,
      this.title,
      this.departure,
      this.destination,
      this.description,
      this.policy,
      this.thumbnailUrl,
      this.maxOccupancy,
      this.type,
      this.status});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    departure = json['departure'];
    destination = json['destination'];
    description = json['description'];
    policy = json['policy'];
    thumbnailUrl = json['thumbnailUrl'];
    maxOccupancy = json['maxOccupancy'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['description'] = this.description;
    data['policy'] = this.policy;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['maxOccupancy'] = this.maxOccupancy;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
