import 'package:food_delievery_app/Controller/AdminController/ChatController.dart';

import '../Widgets/AllExport.dart';

class AdminChatPage extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
   AdminChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Admin Chat Page"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("chatRooms").snapshots(), 
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var chatrooms = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: chatrooms.length,
            itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
            );
          },);
        },),
    );
  }
}