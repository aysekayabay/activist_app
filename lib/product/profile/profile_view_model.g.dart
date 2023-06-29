// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$favEventsGroupsAtom =
      Atom(name: '_ProfileViewModelBase.favEventsGroups', context: context);

  @override
  List<GroupModel> get favEventsGroups {
    _$favEventsGroupsAtom.reportRead();
    return super.favEventsGroups;
  }

  @override
  set favEventsGroups(List<GroupModel> value) {
    _$favEventsGroupsAtom.reportWrite(value, super.favEventsGroups, () {
      super.favEventsGroups = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ProfileViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_ProfileViewModelBaseActionController =
      ActionController(name: '_ProfileViewModelBase', context: context);

  @override
  bool containsUser(GroupModel groupModel) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.containsUser');
    try {
      return super.containsUser(groupModel);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic leaveGroup(BuildContext context, EventModel? eventModel) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.leaveGroup');
    try {
      return super.leaveGroup(context, eventModel);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic joinGroup(BuildContext context, EventModel? eventModel) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.joinGroup');
    try {
      return super.joinGroup(context, eventModel);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeFav(EventModel eventModel) {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.removeFav');
    try {
      return super.removeFav(eventModel);
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favEventsGroups: ${favEventsGroups},
isLoading: ${isLoading}
    ''';
  }
}
