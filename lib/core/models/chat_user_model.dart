// ignore_for_file: file_names

class ChatUserModel {
  String? id;
  String? name;
  String? email;
  String? about;
  String? image;
  String? createdAt;
  String? lastActivated;
  String? pushToken;
  bool? online;

  ChatUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.createdAt,
    required this.lastActivated,
    required this.pushToken,
    required this.online,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      about: json['about'],
      image: json['image'],
      createdAt: json['created_at'],
      lastActivated: json['last_activated'],
      pushToken: json['push_token'],
      online: json['online'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'about': about,
      'image': image,
      'created_at': createdAt,
      'last_activated': lastActivated,
      'push_token': pushToken,
      'online': online,
    };
  }
}
