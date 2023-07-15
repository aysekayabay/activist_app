import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/image/cached_network_image_widget.card.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
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

class _ChatViewState extends BaseState<ChatView> {
  TextEditingController controller = TextEditingController();
  void onSendMessage() async {
    UserModel? currentUser = AuthService.instance.currentUser;
    if (controller.text.isNotEmpty && currentUser != null) {
      MessageModel newMessage =
          MessageModel(sentBy: SentBy(fullname: currentUser.fullname, id: currentUser.userID, photoUrl: currentUser.photoUrl), type: "text", content: controller.text, time: Timestamp.now());
      await EventsService.instance.pushMessage(widget.groupModel.event!.id.toString(), newMessage);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(context),
      body: StreamBuilder<List<MessageModel>>(
        stream: EventsService.instance.getGroupChatsStream(widget.groupModel.event!.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<MessageModel> messages = snapshot.data!;
            messages.sort((a, b) => b.time!.compareTo(a.time!));
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.lowSize),
                    child: ListView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        MessageModel message = messages[index];
                        print(" $index :  ${message.sentBy?.fullname} - ${message.content}");
                        bool noImage = (index < messages.length - 1) && (message.sentBy?.id == messages[index + 1].sentBy?.id);
                        return MessageItem(message: message, noImage: noImage, index: index);
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff3F3E3E),
                  ),
                  padding: EdgeInsets.all(AppSizes.lowSize),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: controller,
                        style: themeData.textTheme.bodyMedium,
                        decoration: InputDecoration(hintStyle: TextStyle().copyWith(color: AppColors.grey), hintText: "Mesaj yazın"),
                      )),
                      IconButton(
                          onPressed: () {
                            onSendMessage();
                          },
                          icon: Icon(Icons.send, color: AppColors.vanillaShake)),
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

  AppBar chatAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(onTap: () => Navigator.of(context).pop(), child: Image.asset(ImageConstants.BACK_WITH_SHADOW)),
      toolbarHeight: kToolbarHeight + AppSizes.mediumSize,
      backgroundColor: Color(0xff3F3E3E),
      title: Row(
        children: [
          cachedNetworkImageWidget(
            height: 50,
            width: 50,
            posterUrl: widget.groupModel.event?.posterUrl,
            borderRadius: AppRadius.primaryRadius,
          ),
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              width: deviceWidth,
              height: kToolbarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.groupModel.event?.name ?? '',
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                      child: Text(
                    widget.groupModel.event!.start.toString().formattedDate + " - " + widget.groupModel.event!.start.toString().formattedTime,
                    style: themeData.textTheme.displaySmall,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
