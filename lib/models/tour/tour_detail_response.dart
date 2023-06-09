class TourDetailResponse {
  List<Schedules>? schedules;
  List<TourFlows>? tourFlows;
  List<Carousel>? carousel;
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? description;
  Null policy;
  String? thumbnailUrl;
  int? maxOccupancy;
  String? type;
  String? status;

  TourDetailResponse(
      {this.schedules,
      this.tourFlows,
      this.carousel,
      this.id,
      this.title,
      this.departure,
      this.destination,
      this.description,
      this.policy,
      this.thumbnailUrl,
      this.maxOccupancy,
      this.type,
      this.status});

  TourDetailResponse.fromJson(Map<String, dynamic> json) {
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
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    if (this.tourFlows != null) {
      data['tourFlows'] = this.tourFlows!.map((v) => v.toJson()).toList();
    }
    if (this.carousel != null) {
      data['carousel'] = this.carousel!.map((v) => v.toJson()).toList();
    }
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
