class TicketListResponse {
  String? content;
  String? id;
  Null? imageUrl;
  String? tourId;
  String? travelerId;
  String? type;

  TicketListResponse(
      {this.content,
      this.id,
      this.imageUrl,
      this.tourId,
      this.travelerId,
      this.type});

  TicketListResponse.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    tourId = json['tourId'];
    travelerId = json['travelerId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['tourId'] = this.tourId;
    data['travelerId'] = this.travelerId;
    data['type'] = this.type;
    return data;
  }
}
