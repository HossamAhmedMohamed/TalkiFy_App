import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whats_app/core/models/chat_user_model.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User user = auth.currentUser!;

  static Future createUser() async {
    ChatUserModel chatUserModel = ChatUserModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        about: 'Hello',
        image: '',
        createdAt: DateTime.now().toString(),
        lastActivated: DateTime.now().toString(),
        pushToken: '',
        online: false);

    await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUserModel.toJson());
  }
}
