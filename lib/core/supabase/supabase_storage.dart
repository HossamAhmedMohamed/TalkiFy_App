import 'package:whats_app/core/firebase/fire_base_room.dart';

class SupabaseStorage {
  Future sendImage({
    required String roomId,
    required String imgUrl,
    required String uId,
  }) async {
    FireBaseRoom().sendMessage(uId, imgUrl, roomId, type: 'image');
  }
}
