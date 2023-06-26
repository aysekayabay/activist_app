// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailPageViewModel on _DetailPageViewModelBase, Store {
  late final _$favListAtom =
      Atom(name: '_DetailPageViewModelBase.favList', context: context);

  @override
  List<EventModel> get favList {
    _$favListAtom.reportRead();
    return super.favList;
  }

  @override
  set favList(List<EventModel> value) {
    _$favListAtom.reportWrite(value, super.favList, () {
      super.favList = value;
    });
  }

  late final _$isFavAtom =
      Atom(name: '_DetailPageViewModelBase.isFav', context: context);

  @override
  bool get isFav {
    _$isFavAtom.reportRead();
    return super.isFav;
  }

  @override
  set isFav(bool value) {
    _$isFavAtom.reportWrite(value, super.isFav, () {
      super.isFav = value;
    });
  }

  late final _$favButtonAsyncAction =
      AsyncAction('_DetailPageViewModelBase.favButton', context: context);

  @override
  Future<void> favButton(EventModel event) {
    return _$favButtonAsyncAction.run(() => super.favButton(event));
  }

  late final _$_DetailPageViewModelBaseActionController =
      ActionController(name: '_DetailPageViewModelBase', context: context);

  @override
  dynamic init(EventModel eventModel) {
    final _$actionInfo = _$_DetailPageViewModelBaseActionController.startAction(
        name: '_DetailPageViewModelBase.init');
    try {
      return super.init(eventModel);
    } finally {
      _$_DetailPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favList: ${favList},
isFav: ${isFav}
    ''';
  }
}
