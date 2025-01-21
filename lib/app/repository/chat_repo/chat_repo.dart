import 'package:cloud_firestore/cloud_firestore.dart';
import '../../mvvm/model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import '../../mvvm/model/firebase_user_profile_model/firebase_user_model.dart';
import '../../mvvm/model/message_model/message_model.dart';

class ChatRepo{
  // Generates a unique chat box ID by sorting the user IDs and joining them with an underscore.
  static String generateChatBoxId(String userId, String recipientId) {
    List<String> sortedIds = [userId, recipientId]..sort();
    String chatBoxId = sortedIds.join('_');
    return chatBoxId;
  }


  // Sends a chat message by adding it to the Firestore database under the specific chat box and message ID.
  static sendChatMessage({
    required Map<String, dynamic> dateMap,
    required String messageId,
    required recipientUserId,
    required chatBoxId,
  }) {
    print('====================================== message send  by repo ');

    final FirebaseRef = FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .collection("chats")
        .doc(messageId);

    try {
      FirebaseRef.set(dateMap).then((value) {
        print('====================================== $dateMap message send ');
      });
    } catch (e) {
      // Error handling logic can go here
    }
  }

  // Listens to changes in chat metadata and streams updated ChatMateDataModel objects.
  static Stream<ChatMetadataModel> getMetaData(String chatBoxId) {
    return FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .snapshots()
        .map((snapshot) {
      return ChatMetadataModel(
        lastMessage: snapshot.get('lastMessage'),
        lastMessageTime: snapshot.get('lastMessageTime'),
        chatId: snapshot.get('chatId'),
        chatType: snapshot.get('chatType'),
        members: snapshot.get('members'),
      );
    });
  }

  // Writes metadata to Firestore for a specific chat box.
  static writeMetaDate(String chatBoxId, ChatMetadataModel mateDataModel) {
    return FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .set(mateDataModel.toJson());
  }

  // Updates metadata in Firestore for a specific chat box.
  static updateMetaDate(Map<String, dynamic> data, String chatBoxId) {
    return FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .update(data);
  }

  // Retrieves and streams a list of chat messages for a specific chat box, ordered by server timestamp.
  static Stream<List<MessageModel>> getOrderedChatsModelList(String chatBoxId) {
    return FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .collection('chats')
        .orderBy('messageSendTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return MessageModel(
          messageId: document.get('messageId'),
          readStatus: document.get('readStatus'),
          messageBody: document.get('messageBody'),
          messageFileUrl: document.get('messageFileUrl'),
          messageFileType: document.get('messageFileType'),
          messageType: document.get('messageType'),
          messageSenderId: document.get('messageSenderId'),
          messageReceiverId: document.get('messageReceiverId'),
          messageSendTime: document.get('messageSendTime'),
        );
      }).toList();
    });
  }

  // Streams the count of unread messages in a chat box for a specific user.
  static Stream<int> getUnreadMessageCount(String chatBoxId, String currentUserId) {
    print('Getting unread message count for ChatBox: $chatBoxId, User: $currentUserId');

    return FirebaseFirestore.instance
        .collection('UsersChatBox')
        .doc(chatBoxId)
        .collection('chats')
        .snapshots()
        .map((snapshot) {
      // Filter unread messages not sent by the current user
      final unreadMessages = snapshot.docs.where((document) {
        final readStatus = document.data()['readStatus'] as String?;
        final messageSenderId = document.data()['messageSenderId'] as String?;
        return readStatus == 'unread' && messageSenderId != currentUserId;
      });
      return unreadMessages.length;
    });
  }



  // Deletes a specific message from Firestore.
  static updateMessage( {required String chatBoxId, required String messageId, required Map<String, dynamic> updatedData}) {
    try {
      FirebaseFirestore.instance
          .collection('UsersChatBox')
          .doc(chatBoxId)
          .collection('chats')
          .doc(messageId)
          .update(
          updatedData
      );
    } catch (e) {
      print('ERROR IS UPDATING MESSAGE $e');
    }
  } // Deletes a specific message from Firestore.


  // Adds user data to Firestore under the 'Users' collection.
  static addUserDataOnFirebase({
    required FireBaseUserModel userDataModel,
  }) {
    final FirebaseRef = FirebaseFirestore.instance.collection('Users');

    try {
      print('add user called');
      FirebaseRef.doc(userDataModel.userAppId).set(userDataModel.toJson());
    } catch (e) {
      print('add userERROr $e');
      // Error handling logic can go here
    }
  }

  // Deletes a user account from Firestore by user ID.
  static deleteUserAccount({required String userId}) {
    FirebaseFirestore.instance.collection('Users').doc(userId).delete();
  }

  // Creates a new FireBaseUserModel instance with default values and provided parameters.
  static FireBaseUserModel createFireBaseUserModel({
    required String userAppId,
    required String profileImage,
    required String userName,
    required String role,
  }) {
    return FireBaseUserModel(
      userName: userName,
      role: role,
      status: '',
      profileImage: profileImage,

      fireId: DateTime.now().millisecondsSinceEpoch.toString(),
      userAppId: userAppId,

    );
  }

  // Streams a specific user's data from Firestore and maps it to a FireBaseUserModel.
  static Stream<FireBaseUserModel?> getFireBaseUsersIdStream(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots()
        .map((document) {
      if (!document.exists) {
        print("Document does not exist for userId: $userId");
        return null;
      }

      return FireBaseUserModel(
        fireId: document.data()?['fireId'] ?? '',
        userAppId: document.data()?['userAppId'] ?? '',
        userName: document.data()?['userName'] ?? '',
        role: document.data()?['role'] ?? '',
        status: document.data()?['status'] ?? '',
        profileImage: document.data()?['profileImage'] ?? '',
      );
    });
  }

  static Future<FireBaseUserModel?> getFireBaseUsersIdOneTime(String userId) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (!document.exists) {
        print("Document does not exist for userId: $userId");
        return null;
      }

      return FireBaseUserModel(
        fireId: document.data()?['fireId'] ?? '',
        userAppId: document.data()?['userAppId'] ?? '',
        userName: document.data()?['userName'] ?? '',
        role: document.data()?['role'] ?? '',
        status: document.data()?['status'] ?? '',
        profileImage: document.data()?['profileImage'] ?? '',
      );
    } catch (e) {
      print("Error fetching user document: $e");
      return null;
    }
  }

  // Updates a user's data in Firestore with the provided data.
  static updateUserDate(String userId, Map<String, dynamic> data) {
    FirebaseFirestore.instance.collection('Users').doc(userId).update(data);
  }

  static Stream<QuerySnapshot> getUserInbox(String userId) {
    print("Fetching chat for user: $userId");

    try {
      return FirebaseFirestore.instance
          .collection('UsersChatBox') // Name of the Firestore collection
          .where('members', arrayContains: userId) // Filters where 'members' contains userId
          // .orderBy("lastMessageTime" ,descending : true )
          .snapshots();
    }  catch (e) {
      // TODO
      print('Error in inbox getting $e');
      return Stream.empty();
    }
// Returns a stream of query snapshots
  }
}
