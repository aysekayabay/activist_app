import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/model/message_model.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';

class GroupModel {
  EventModel? event;
  List<UserModel>? users;
  List<MessageModel>? messages;

  GroupModel({this.event, this.users, this.messages});

  GroupModel.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null ? EventModel.fromJson(json['event']) : null;
    users = (json['users'] ?? []).map((element) => UserModel.fromJson(element)).toList().cast<UserModel>();
    messages = (json['messages'] ?? []).map((element) => UserModel.fromJson(element)).toList().cast<MessageModel>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((user) => user.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((message) => message.toJson()).toList();
    }
    return data;
  }
}
