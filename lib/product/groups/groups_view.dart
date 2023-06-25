import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:flutter/material.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends BaseState<GroupsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(20), child: Text("Groups", style: themeData.textTheme.headline1)),
        // Column(children: List.generate(, (index) => null),)
      ],
    );
  }
}
