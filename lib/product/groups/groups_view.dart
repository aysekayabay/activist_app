import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/product/groups/groups_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(20), child: Text("Groups", style: themeData.textTheme.headline1)),
        Observer(builder: (_) {
          return _viewModel.isLoading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Column(
                  children: List.generate(
                      _viewModel.groups.length,
                      (index) => Container(
                            child: Text(
                              _viewModel.groups[index].event?.name ?? '',
                              style: themeData.textTheme.headline1,
                            ),
                          )),
                );
        })
      ],
    );
  }
}
