class Notifications {
  String? title;
  String? message;
  String? createdAt;

  Notifications({this.title, this.message, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}