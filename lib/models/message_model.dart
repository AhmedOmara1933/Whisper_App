class MessageModel {
  String? senderId;
  String? receiverId;
  String? messageText;
  String? messageDate;
  // String? messageImage;

  MessageModel(
      {this.senderId, this.receiverId, this.messageDate, this.messageText,});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    messageText = json['messageText'];
    messageDate = json['messageDate'];
    //messageImage = json['messageImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'messageText': messageText,
      'messageDate': messageDate,
      //'messageImage': messageImage,
    };
  }
}
