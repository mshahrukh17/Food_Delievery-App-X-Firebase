// ignore_for_file: must_be_immutable

import '../../Controller/AdminController/ChatController.dart';
import '../../Widgets/AllExport.dart';

class UserChatPage extends StatelessWidget {
  final String userId; // User ki ID
  final ChatController chatController = Get.put(ChatController());
  TextEditingController messagecontroller = TextEditingController();
   UserChatPage({super.key, required this.userId});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatController.getMessages(userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['message'] ?? "No msg"),
                      subtitle: Text(message['sender'] ?? "No sndr"),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messagecontroller,
                    decoration: InputDecoration(hintText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    chatController.sendmessages(userId, messagecontroller.text, 'user');
                    messagecontroller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
