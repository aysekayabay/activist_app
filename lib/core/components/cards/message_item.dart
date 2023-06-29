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
    bool hasFullname = message.sentBy != null && message.sentBy!.fullname != null;
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(left: AppSizes.lowSize, bottom: sentByMe ? AppSizes.lowSize : 0) + EdgeInsets.only(top: !sentByMe ? AppSizes.mediumSize : 0),
        padding: EdgeInsets.all(AppSizes.lowSize),
        decoration: BoxDecoration(
            color: AppColors.messageGrey,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSizes.mediumSize)) +
                BorderRadius.only(topLeft: Radius.circular(sentByMe ? AppSizes.mediumSize : 0), topRight: Radius.circular(!sentByMe ? AppSizes.mediumSize : 0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hasFullname && !sentByMe
                ? Text(
                    "-${message.sentBy?.fullname}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGrey),
                  )
                : SizedBox(),
            Text(
              message.content,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget image(bool sentByMe) {
    print(message.sentBy!.photoUrl);
    bool hasPhotoUrl = message.sentBy != null && message.sentBy!.photoUrl != null && message.sentBy!.photoUrl!.isNotEmpty;
    return !sentByMe && hasPhotoUrl
        ? ClipOval(
            child: Image.network(
            message.sentBy!.photoUrl!,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ))
        : SizedBox();
  }
}
