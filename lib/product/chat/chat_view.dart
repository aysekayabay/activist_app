import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/model/group_model.dart';
import 'package:akademi_bootcamp/core/model/message_model.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/components/cards/message_item.dart';
import '../../core/services/firestore/events_service.dart';

class ChatView extends StatefulWidget {
  final GroupModel groupModel;
  const ChatView({super.key, required this.groupModel});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController controller = TextEditingController();
  void onSendMessage() async {
    UserModel? currentUser = AuthService.instance.currentUser;
    if (controller.text.isNotEmpty && currentUser != null) {
      MessageModel newMessage = MessageModel(
          sentBy: SentBy(fullname: currentUser.fullname, id: currentUser.userID, photoUrl: currentUser.photoUrl), type: "text", content: controller.text, time: FieldValue.serverTimestamp());
      await EventsService.instance.pushMessage(widget.groupModel.event!.id.toString(), newMessage);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.groupModel.event?.name ?? '', style: Theme.of(context).textTheme.displayLarge),
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: EventsService.instance.getGroupChatsStream(widget.groupModel.event!.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<MessageModel> messages = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.lowSize),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        MessageModel message = messages[messages.length - index - 1];
                        return MessageItem(message: message);
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: AppColors.bgColor),
                  padding: EdgeInsets.all(AppSizes.lowSize),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: controller,
                        style: TextStyle().copyWith(color: AppColors.vanillaShake),
                        decoration: InputDecoration(hintStyle: TextStyle().copyWith(color: AppColors.grey), hintText: "Mesaj yazın"),
                      )),
                      IconButton(
                          onPressed: () {
                            onSendMessage();
                          },
                          icon: Icon(Icons.send)),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text('Bir hata oluştu');
        },
      ),
    );
  }
}
