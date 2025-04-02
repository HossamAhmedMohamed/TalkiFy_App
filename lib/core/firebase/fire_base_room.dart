import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app/core/models/chat_room_model.dart';
import 'package:whats_app/core/models/message_model.dart';

class FireBaseRoom {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String myId = FirebaseAuth.instance.currentUser!.uid;

  Future createRoom(String email) async {
    QuerySnapshot userEmail = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myId, userId]..sort((a, b) => a.compareTo(b));

      QuerySnapshot roomExist = await firebaseFirestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();

      if (roomExist.docs.isEmpty && userId != myId) {
        ChatRoomModel chatRoomModel = ChatRoomModel(
          id: members.toString(),
          members: members,
          lastMessage: '',
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await firebaseFirestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoomModel.toJson());
      } else if (roomExist.docs.isEmpty && userId == myId) {
        Fluttertoast.showToast(msg: 'you cannot chat with yourself');
      } else {
        Fluttertoast.showToast(msg: 'Chat already exist');
      }
    } else {
      Fluttertoast.showToast(msg: 'User not found');
    }
  }

  Future sendMessage(String uId, String msg, String roomId,
      {String? type}) async {
    // QuerySnapshot userName = await firebaseFirestore
    //     .collection('users')
    //     .where('id', isEqualTo: uId)
    //     .get();
    // String username =
    //     (userName.docs.first.data() as Map<String, dynamic>)['name'];
    String messageId = const Uuid().v1();
    MessageModel message = MessageModel(
        id: messageId,
        toId: uId,
        fromId: myId,
        msg: msg,
        type: type ?? 'text',
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        read: '');

    await firebaseFirestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .set(message.toJson());

    firebaseFirestore.collection('rooms').doc(roomId).update({
      'lastMessage': type == 'image' ? 'Photo' : msg,
      'lastMessageTime': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future readMessage(String roomId, String msgId) async {
    await firebaseFirestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
