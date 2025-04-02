class ChatRoomModel {
  String? id;
  List members;
  String? lastMessage;
  String? lastMessageTime;
  String? createdAt;

  ChatRoomModel({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] ?? "",
      members: json['members'] ?? [],
      lastMessage: json['lastMessage'] ?? "",
      lastMessageTime: json['lastMessageTime'] ?? "",
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'createdAt': createdAt,
    };
  }
}
