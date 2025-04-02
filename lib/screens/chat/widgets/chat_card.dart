import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/models/chat_room_model.dart';
import 'package:whats_app/core/models/chat_user_model.dart';
import 'package:whats_app/screens/chat/chat_screen.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chatRoom,
  });

  final ChatRoomModel chatRoom;
  @override
  Widget build(BuildContext context) {
    String userId = chatRoom.members
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .first;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatUserModel user = ChatUserModel.fromJson(snapshot.data!.data()!);
            return Card(
              child: ListTile(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            roomId: chatRoom.id!,
                            user: user,
                          ),
                        ),
                      ),
                  leading: const CircleAvatar(),
                  title: Text(user.name!),
                  subtitle: chatRoom.lastMessage == null
                      ? Text(user.about!)
                      : Text( chatRoom.lastMessage!),
                  trailing: const Badge(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    label: Text("3"),
                    largeSize: 30,
                  )),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
