// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupsViewModel on _GroupsViewModelBase, Store {
  late final _$groupsAtom =
      Atom(name: '_GroupsViewModelBase.groups', context: context);

  @override
  List<GroupModel> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(List<GroupModel> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GroupsViewModelBase.isLoading', context: context);

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

  late final _$getGroupsAsyncAction =
      AsyncAction('_GroupsViewModelBase.getGroups', context: context);

  @override
  Future getGroups() {
    return _$getGroupsAsyncAction.run(() => super.getGroups());
  }

  @override
  String toString() {
    return '''
groups: ${groups},
isLoading: ${isLoading}
    ''';
  }
}
