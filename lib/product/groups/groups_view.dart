import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:akademi_bootcamp/product/profile/profile_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../core/components/cards/group_item_card.dart';
import '../../core/constants/theme/theme_constants.dart';
import '../../core/model/group_model.dart';
import '../../core/model/message_model.dart';
import '../chat/chat_view.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends BaseState<GroupsView> {
  ProfileViewModel _viewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: EventsService.instance.fetchUserGroups(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<GroupModel> groupList = snapshot.data!.docs.map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
                List<GroupModel> filteredGroups = groupList.where((group) {
                  List<SentBy> users = group.users ?? [];
                  List<SentBy> myUserList = users.where((user) => user.id == AuthService.instance.currentUser?.userID).toList();
                  return myUserList.isNotEmpty;
                }).toList();

                return Container(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: ListView.builder(
                      itemCount: filteredGroups.length,
                      itemBuilder: (context, index) => Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (context) {
                                    _viewModel.leaveGroup(context, filteredGroups[index].event);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: AppColors.orange,
                                          action: SnackBarAction(
                                            label: "Geri al",
                                            onPressed: () {
                                              _viewModel.joinGroup(filteredGroups[index].event, context);
                                            },
                                          ),
                                          content: Text("Gruptan ayrıldınız.")),
                                    );
                                  },
                                  backgroundColor: AppColors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Gruptan Ayrıl')
                            ],
                          ),
                          child: GroupItemCard(
                              group: filteredGroups[index],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ChatView(groupModel: filteredGroups[index]);
                                  },
                                ));
                              }))),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(height: deviceHeight, child: Center(child: CircularProgressIndicator()));
              } else {
                return SizedBox(height: deviceHeight, child: Center(child: Text("Henüz bir gruba katılmadın sanırım..")));
              }
            }));
  }
}
