// enum MessageFileType { image, video, audio, document, other }

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageBody;
  final String? messageFileUrl;
  final String messageType;
  final String messageSenderId;
  final String messageReceiverId;
  final String? messageFileType; // Updated to use enum
  final String readStatus;
  final String messageId;
  final dynamic messageSendTime;
/// NOTE: using  *[fieldValue.serverTime()]* provided by firebase value will
  /// be added be server to avoid time zone differs in user device

  // Constructor
  const MessageModel({
    required this.messageBody,
    this.messageFileUrl,
    required this.messageType,
    required this.messageSenderId,
    required this.messageReceiverId,
    this.messageFileType,
    required this.readStatus,
    required this.messageSendTime,
    required this.messageId,
  });

  // Factory method to create an instance from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageBody: json['messageBody'],
      messageFileUrl: json['messageFileUrl'],
      messageType: json['messageType'],
      messageSenderId: json['messageSenderId'],
      messageReceiverId: json['messageReceiverId'],
      messageFileType: json['messageFileType'] ?? '',

      readStatus: json['readStatus'],
      messageSendTime: json['messageSendTime'],
      messageId: json['messageId'],
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'messageBody': messageBody,
      'messageFileUrl': messageFileUrl,
      'messageType': messageType,
      'messageSenderId': messageSenderId,
      'messageReceiverId': messageReceiverId,
      'messageFileType': messageFileType?.toString().split('.').last,
      'readStatus': readStatus,
      'messageSendTime': messageSendTime,
      'messageId': messageId,
    };
  }

  // CopyWith method for immutability
  MessageModel copyWith({
    String? messageBody,
    String? messageFileUrl,
    String? messageType,
    String? messageSenderId,
    String? messageReceiverId,
    String? messageFileType,
    String? readStatus,
    FieldValue? messageSendTime,
    String? messageId,
  }) {
    return MessageModel(
      messageBody: messageBody ?? this.messageBody,
      messageFileUrl: messageFileUrl ?? this.messageFileUrl,
      messageType: messageType ?? this.messageType,
      messageSenderId: messageSenderId ?? this.messageSenderId,
      messageReceiverId: messageReceiverId ?? this.messageReceiverId,
      messageFileType: messageFileType ?? this.messageFileType,
      readStatus: readStatus ?? this.readStatus,
      messageSendTime: messageSendTime ?? this.messageSendTime,
      messageId: messageId ?? this.messageId,
    );
  }

  // Equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageModel &&
        other.messageBody == messageBody &&
        other.messageFileUrl == messageFileUrl &&
        other.messageType == messageType &&
        other.messageSenderId == messageSenderId &&
        other.messageReceiverId == messageReceiverId &&
        other.messageFileType == messageFileType &&
        other.readStatus == readStatus &&
        other.messageSendTime == messageSendTime &&
        other.messageId == messageId;
  }

  @override
  int get hashCode => Object.hash(
    messageBody,
    messageFileUrl,
    messageType,
    messageSenderId,
    messageReceiverId,
    messageFileType,
    readStatus,
    messageSendTime,
    messageId,
  );
}


enum MessageType {text , call , file , audio , deleted}
enum ReadStatues {unread , read , sent , unsent}



