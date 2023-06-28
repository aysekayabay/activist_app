import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';
import '../../model/message_model.dart';
import '../../services/auth/auth_service.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool sentByMe = message.sentBy?.id == AuthService.instance.currentUser?.userID;
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            image(sentByMe),
            content(sentByMe, context),
          ],
        ),
      ),
    );
  }

  Widget content(bool sentByMe, BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(left: AppSizes.lowSize, bottom: sentByMe ? AppSizes.lowSize : 0),
        padding: EdgeInsets.all(AppSizes.lowSize),
        decoration: BoxDecoration(
            color: AppColors.messageGrey,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSizes.mediumSize)) +
                BorderRadius.only(topLeft: Radius.circular(sentByMe ? AppSizes.mediumSize : 0), topRight: Radius.circular(!sentByMe ? AppSizes.mediumSize : 0))),
        child: Text(
          message.content,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ),
    );
  }

  Widget image(bool sentByMe) {
    return !sentByMe
        ? ClipOval(
            child: Image.network(
            "https://picsum.photos/200/300",
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ))
        : SizedBox();
  }
}
