import 'package:akademi_bootcamp/core/components/image/cached_network_image_widget.card.dart';
import 'package:akademi_bootcamp/core/model/group_model.dart';
import 'package:akademi_bootcamp/core/model/message_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

// ignore: must_be_immutable
class GroupItemCard extends StatelessWidget {
  void Function()? onTap;
  final GroupModel group;
  final MessageModel? lastMessage;
  GroupItemCard({super.key, required this.group, this.onTap, this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            cachedNetworkImageWidget(
              posterUrl: group.event?.posterUrl,
              width: 80,
              height: 80,
              shape: BoxShape.circle,
            ),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width - AppSizes.highSize * 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text(group.event?.name ?? '', style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text(group.event?.venue?.name ?? '', overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text(message(lastMessage?.sentBy?.fullname ?? '', lastMessage?.content ?? ''), overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String message(String name, String message) {
    String? uid = AuthService.instance.uid;
    if (lastMessage?.sentBy?.id == uid)
      return "Sen: $message";
    else if (name.isEmpty && message.isEmpty) return "";
    return "$name: $message";
  }
}
