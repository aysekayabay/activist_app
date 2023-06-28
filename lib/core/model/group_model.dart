import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/model/message_model.dart';

class GroupModel {
  EventModel? event;
  List<SentBy>? users;
  List<MessageModel>? messages;
  
  int? favCount;

  GroupModel({this.event, this.users, this.messages, this.favCount});

  GroupModel.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null ? EventModel.fromJson(json['event']) : null;
    users = (json['users'] ?? []).map((element) => SentBy.fromJson(element)).toList().cast<SentBy>();
    messages = (json['messages'] ?? []).map((element) => MessageModel.fromJson(element)).toList().cast<MessageModel>();
    favCount = json['fav_count'] ?? '';
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
    data['fav_count'] = this.favCount;
    return data;
  }
}
