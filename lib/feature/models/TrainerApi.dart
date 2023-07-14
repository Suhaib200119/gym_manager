class TrainerApi {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? age;
  String? maritalStatus;
  String? fcmToken;
  String? avgRating;

  TrainerApi(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.age,
        this.maritalStatus,
        this.fcmToken,
        this.avgRating});

  TrainerApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    fcmToken = json['fcm_token'];
    avgRating = json['avgRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['fcm_token'] = this.fcmToken;
    data['avgRating'] = this.avgRating;
    return data;
  }
}