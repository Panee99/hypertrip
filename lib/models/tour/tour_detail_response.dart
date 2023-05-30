class TourDetailResponse {
  String? id;
  String? title;
  double? adultPrice;
  double? childrenPrice;
  double? infantPrice;
  String? code;
  String? departure;
  String? destination;
  String? endTime;
  int? maxOccupancy;
  String? startTime;
  String? description;
  String? thumbnailUrl;
  String? type;
  String? status;
  List<Schedules>? schedules;
  List<TourFlows>? tourFlows;
  List<Carousel>? carousel;

  TourDetailResponse(
      {this.id,
      this.title,
      this.adultPrice,
      this.childrenPrice,
      this.infantPrice,
      this.code,
      this.departure,
      this.destination,
      this.endTime,
      this.maxOccupancy,
      this.startTime,
      this.description,
      this.thumbnailUrl,
      this.type,
      this.status,
      this.schedules,
      this.tourFlows,
      this.carousel});

  TourDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    adultPrice = json['adultPrice'];
    childrenPrice = json['childrenPrice'];
    infantPrice = json['infantPrice'];
    code = json['code'];
    departure = json['departure'];
    destination = json['destination'];
    endTime = json['endTime'];
    maxOccupancy = json['maxOccupancy'];
    startTime = json['startTime'];
    description = json['description'];
    thumbnailUrl = json['thumbnailUrl'];
    type = json['type'];
    status = json['status'];
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
    if (json['tourFlows'] != null) {
      tourFlows = <TourFlows>[];
      json['tourFlows'].forEach((v) {
        tourFlows!.add(new TourFlows.fromJson(v));
      });
    }
    if (json['carousel'] != null) {
      carousel = <Carousel>[];
      json['carousel'].forEach((v) {
        carousel!.add(new Carousel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['adultPrice'] = this.adultPrice;
    data['childrenPrice'] = this.childrenPrice;
    data['infantPrice'] = this.infantPrice;
    data['code'] = this.code;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['endTime'] = this.endTime;
    data['maxOccupancy'] = this.maxOccupancy;
    data['startTime'] = this.startTime;
    data['description'] = this.description;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['type'] = this.type;
    data['status'] = this.status;
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    if (this.tourFlows != null) {
      data['tourFlows'] = this.tourFlows!.map((v) => v.toJson()).toList();
    }
    if (this.carousel != null) {
      data['carousel'] = this.carousel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedules {
  String? id;
  String? description;
  int? sequence;

  Schedules({this.id, this.description, this.sequence});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    sequence = json['sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['sequence'] = this.sequence;
    return data;
  }
}

class TourFlows {
  String? id;
  double? longitude;
  double? latitude;
  String? arrivalTime;
  Null? description;

  TourFlows(
      {this.id,
      this.longitude,
      this.latitude,
      this.arrivalTime,
      this.description});

  TourFlows.fromJson(Map<String, dynamic> json) {
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

class Carousel {
  String? id;
  String? contentType;
  String? url;

  Carousel({this.id, this.contentType, this.url});

  Carousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['contentType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contentType'] = this.contentType;
    data['url'] = this.url;
    return data;
  }
}
