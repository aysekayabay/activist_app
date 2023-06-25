class MessageModel {
  String? id;
  dynamic content;
  MessageModel({this.id, this.content});
  
  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    content = json['content'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}
