
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMetadataModel {
  final String chatId;
  final String chatType; // "direct" or "group"
  final List members; // List of user IDs
  final String? lastMessage;
  final dynamic lastMessageTime;

  ChatMetadataModel({
    required this.chatId,
    required this.chatType,
    required this.members,
    this.lastMessage,
    this.lastMessageTime,
  });

  // Factory method to create an instance from Firestore document snapshot
  factory ChatMetadataModel.fromJson(Map<String, dynamic> json) {
    return ChatMetadataModel(
      chatId: json['chatId'] ?? '',
      chatType: json['chatType'] ?? 'direct',
      members: List<String>.from(json['members'] ?? []),
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] ?? Timestamp.now(),
    );
  }

  // Method to convert the instance to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'chatType': chatType,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }
}


enum ChatType {direct , group}