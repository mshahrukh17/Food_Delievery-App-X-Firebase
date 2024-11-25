// ignore_for_file: unnecessary_cast

import 'package:food_delievery_app/Widgets/AllExport.dart';

class ChatController extends GetxController {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("chatRooms");

  Future<void> sendmessages(String roomID, String message, String sender) async {
    await firestore.doc(roomID).collection("messages").add({
      "message":message,
      "sender":sender,
      "timestamp":FieldValue.serverTimestamp()
    });
  }

   Stream<QuerySnapshot> getMessages(String roomId) {
    return firestore
      .doc(roomId)
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .snapshots();
  }
}
