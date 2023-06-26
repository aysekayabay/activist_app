import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/cards/group_item_card.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/product/chat/chat_view.dart';
import 'package:akademi_bootcamp/product/groups/groups_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends BaseState<GroupsView> {
  GroupsViewModel _viewModel = GroupsViewModel();

  @override
  void initState() {
    _viewModel.getGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(20), child: Text("Groups", style: themeData.textTheme.headlineSmall)),
          Observer(builder: (_) {
            return _viewModel.isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : SizedBox(
                    height: deviceHeight,
                    width: deviceWidth,
                    child: ListView.builder(
                        itemCount: _viewModel.groups.length,
                        itemBuilder: (context, index) => Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(padding: EdgeInsets.zero, onPressed: (context) {}, backgroundColor: AppColors.red, foregroundColor: Colors.white, icon: Icons.delete, label: 'Grubu Sil')
                              ],
                            ),
                            child: GroupItemCard(
                              group: _viewModel.groups[index],
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ChatView(groupModel: _viewModel.groups[index]);
                                  },
                                ));
                              },
                            ))));
          })
        ],
      ),
    );
  }
}
