class SubscriberApi {
  int? id;
  String? name;
  String? userName;
  String? phone;
  int? age;
  int? weight;
  int? height;
  String? maritalStatus;
  String? healthStatus;
  String? subscriptionStart;
  String? subscriptionEnd;
  int? subscriptionId;
  int? trainerId;
  int? firstBatch;
  int? indebtedness;
  Null? image;
  int? status;
  String? trainerName;
  Subscription? subscription;

  SubscriberApi(
      {this.id,
        this.name,
        this.userName,
        this.phone,
        this.age,
        this.weight,
        this.height,
        this.maritalStatus,
        this.healthStatus,
        this.subscriptionStart,
        this.subscriptionEnd,
        this.subscriptionId,
        this.trainerId,
        this.firstBatch,
        this.indebtedness,
        this.image,
        this.status,
        this.trainerName,
        this.subscription});

  SubscriberApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    phone = json['phone'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    maritalStatus = json['marital_status'];
    healthStatus = json['health_status'];
    subscriptionStart = json['subscription_start'];
    subscriptionEnd = json['subscription_end'];
    subscriptionId = json['subscription_id'];
    trainerId = json['trainer_id'];
    firstBatch = json['first_batch'];
    indebtedness = json['indebtedness'];
    image = json['image'];
    status = json['status'];
    trainerName = json['trainer_name'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['marital_status'] = this.maritalStatus;
    data['health_status'] = this.healthStatus;
    data['subscription_start'] = this.subscriptionStart;
    data['subscription_end'] = this.subscriptionEnd;
    data['subscription_id'] = this.subscriptionId;
    data['trainer_id'] = this.trainerId;
    data['first_batch'] = this.firstBatch;
    data['indebtedness'] = this.indebtedness;
    data['image'] = this.image;
    data['status'] = this.status;
    data['trainer_name'] = this.trainerName;
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  int? id;
  String? subscriptionType;
  int? numberExercises;
  int? subscriptionPrice;

  Subscription(
      {this.id,
        this.subscriptionType,
        this.numberExercises,
        this.subscriptionPrice});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionType = json['subscription_type'];
    numberExercises = json['number_exercises'];
    subscriptionPrice = json['subscription_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_type'] = this.subscriptionType;
    data['number_exercises'] = this.numberExercises;
    data['subscription_price'] = this.subscriptionPrice;
    return data;
  }
}
