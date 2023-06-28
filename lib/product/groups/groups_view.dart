import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../core/components/cards/group_item_card.dart';
import '../../core/constants/theme/theme_constants.dart';
import '../../core/model/group_model.dart';
import '../chat/chat_view.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends BaseState<GroupsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: EventsService.instance.fetchUserGroups(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<GroupModel> groupList = snapshot.data!.docs.map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
                print(groupList.length);
                return Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: ListView.builder(
                      itemCount: groupList.length,
                      itemBuilder: (context, index) => Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(padding: EdgeInsets.zero, onPressed: (context) {}, backgroundColor: AppColors.red, foregroundColor: Colors.white, icon: Icons.delete, label: 'Grubu Sil')
                            ],
                          ),
                          child: GroupItemCard(
                              group: groupList[index],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ChatView(groupModel: groupList[index]);
                                  },
                                ));
                              }))),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Center(
                  child: Text("Henüz bir gruba katılmadın sanırım.."),
                );
              }
            }));
  }
}
