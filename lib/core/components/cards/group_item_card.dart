import 'package:akademi_bootcamp/core/model/group_model.dart';
import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

// ignore: must_be_immutable
class GroupItemCard extends StatelessWidget {
  GroupItemCard({super.key, required this.group, this.onTap});
  void Function()? onTap;
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            ClipOval(child: Image.network(group.event?.posterUrl ?? '', width: 80, height: 80, fit: BoxFit.cover)),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width - AppSizes.highSize * 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text(group.event?.name ?? '', style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text(group.event?.venue?.name ?? '', overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
