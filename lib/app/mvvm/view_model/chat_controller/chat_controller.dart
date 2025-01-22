import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fire_chat/app/mvvm/model/firebase_user_profile_model/firebase_user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../config/app_strings.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../repository/chat_repo/chat_repo.dart';
import '../../../services/shared_preferences_helper.dart';
import '../../model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import '../../model/message_model/message_model.dart';






class ChatController extends  GetxController {
  RxBool loader = false.obs;
  RxBool isFirstMessage = true.obs ;
  ScrollController messageScrollController = ScrollController();
  RxBool isScrolled = false.obs  ;

    String formatTimestampToTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('hh:mm a').format(dateTime); // 12-hour format with AM/PM
    return formattedTime;
  }

  void scrollListener() {
    if (messageScrollController.hasClients) {
      // Check if the user has scrolled the list
      final lisScrolled = messageScrollController.offset >= 0;

      // Check if the user is at the bottom
      final isAtBottom = messageScrollController.offset >=
          messageScrollController.position.maxScrollExtent;

      // Update the isScrolled value in the controller
      isScrolled.value = lisScrolled && !isAtBottom;
    }
  }


  void scrollToBottom() {
    if (messageScrollController.hasClients) {
      messageScrollController.jumpTo(messageScrollController.position.maxScrollExtent);
    }
  }


  TextEditingController messageController = TextEditingController();
  Map<String, dynamic>? userDataMap;

  String senderId = '2';

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
  senderId =await  getUserId();
  debugPrint('<<<<<<<<<<<<<<<<<<<<<SENDER ID $senderId>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }




  var loadingStates = <int, bool>{}.obs; // Map to store loading states for each tile


  /// file and image Picker
  Rx<File?> rXfile = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();


  Stream<ChatMetadataModel> getMetaData(String chatBoxId) {
    return ChatRepo.getMetaData(chatBoxId);
  }

  void initChatWithUser(String receiverId) async {
    // String currentUserId = await getUserId();
    String currentUserId = senderId;
    print('init chat with Sender $currentUserId , recevier $receiverId');

    Get.toNamed(Routes.chatView,
        arguments: {
          'currentUserId': currentUserId,
          'receiverId': receiverId,
        }
    );
  }


  Stream<int> getUnreadMessageCount(String chatBoxId, String currentUserId) {
    return ChatRepo.getUnreadMessageCount(chatBoxId, currentUserId);
  }

  void updateUserInbox(userId, chatBoxId) {
    ChatRepo.updateUserDate(userId,
        {
          'inboxIds': FieldValue.arrayUnion([chatBoxId]),
        }

    );
  }


  // Stream<List>? getUserInboxArray() async* {
  //   // Get the user ID asynchronously
  //   final userId = await getUserId();
  //
  //   if (userId != null) {
  //     // Fetch the user stream based on the userId
  //     Stream<FireBaseUserModel?> userStream = ChatRepo.getFireBaseUsersId(userId);
  //
  //     // Map the user stream to extract inbox IDs
  //     yield* userStream.map((user) => user?.inboxIds ?? []);
  //   }
  // }

  void writeMetaData(String chatBoxId, ChatMetadataModel mateDataModel) async {

    ChatRepo.writeMetaDate(chatBoxId, mateDataModel);
  }

  Future<String> getUserId() async {
    FireBaseUserModel? currentUser = await SharedPreferencesService.readUserData();
    String currentUserId ='2';
    /// uncomment this
        // currentUser!.userAppId.toString() ?? '';

    return currentUserId;
  }


  String getChatBoxId(String recipientId, String senderId) {
    String id = ChatRepo.generateChatBoxId(senderId, recipientId);
    print('ChatId is $id');
    return id;
  }

  sendChatWithImageMessage({
    File? file,
    required  MessageType messageType,
    required String chatBoxId,
    required String recipientId,
    required ChatType chatType,
    bool? isFirstMessageOfChat,
  }) async {
    print('send messsage calling ');
    try {
      loader.value = true;
      print('====================== loader Value $loader');
      print(" isFirst message :  ${isFirstMessageOfChat}");


      FieldValue messageTime =  FieldValue.serverTimestamp();

      String lMessageType = messageType.name.toString();

      String lReadStatus = ReadStatues.unread.name;
      String messageId= DateTime
          .now()
          .millisecondsSinceEpoch
          .toString() + Random().nextInt(1000).toString();
      String? imageUrl;
      String? fileExtension;

      // if to send file

      /// if (file != null) {
      ///   // Upload image to Firebase Storage
      ///   String fileName = file.path;
      ///   fileExtension = fPath.extension(fileName);
      ///   print('File extension: $fileExtension');
      ///   final storageRef = FirebaseStorage.instance.ref('UserChatFiles/$chatBoxId/$messageId');
      ///   UploadTask uploadTask = storageRef.putFile(file);
      ///
      ///   await uploadTask;
      ///
      ///   imageUrl = await storageRef.getDownloadURL();
      ///   print('Image URL: $imageUrl');
      /// }

      // Prepare message data
      final messageData = MessageModel(
        messageFileUrl: imageUrl ?? '',
          messageFileType: fileExtension ?? '',
          messageBody: messageController.text.isNotEmpty ? messageController.text : '',
          messageType: lMessageType ,
        messageSenderId: senderId,
          messageReceiverId: recipientId,
          readStatus: lReadStatus,
          messageSendTime:  messageTime,
          messageId: messageId,
    ).toJson();
    /// NOTE: using  *[fieldValue.serverTime()]* provided by firebase value will
    /// be added be server to avoid time zone differs in user device

      print('====================== Message Value $messageData');


    // Send the chat message
      if ( messageController.text.isNotEmpty) {

        /// if message is first of chat then upload meta data else not
      if(isFirstMessageOfChat ?? true) {
        writeMetaData(chatBoxId,
        ChatMetadataModel(
                lastMessage:   messageController.text.isNotEmpty ? messageController.text : 'File',
                lastMessageTime: messageTime,
                chatId: chatBoxId,
                chatType: chatType.name,
                members: [ senderId , recipientId ]
        )
        );

      }
      else{
        ChatRepo.updateMetaDate(
            {
              'lastMessageTime' : messageTime,
              'lastMessage' : messageController.text.isNotEmpty ? messageController.text : 'File',
            }
            , chatBoxId);

      }

      print('====================== Message Sending ${messageData.values}');

      ChatRepo.sendChatMessage(
          messageId: messageId,
          dateMap: messageData,
          recipientUserId: recipientId,
          chatBoxId: chatBoxId,
        );
      }

      // Clean up
      rXfile.value = null;
      messageController.clear();
    } catch (e) {
      // Handle errors
      print('===================== ERROR in message Sending $e');

      // CustomSnackbar.show(
      //     title:'Message Failed',
      //     message: AppStrings.messageSendingFailedText.tr,
      //     backgroundColor: AppColors.negativeRed.withOpacity(.5),
      //     iconData: Icons.error,
      //     iconColor: AppColors.negativeRed,
      //     messageTextColor: AppColors.black,
      //     messageTextList: ['Unable to send message']);

    } finally {
      loader.value = false;
    }
  }




  void unSendMessage(chatBoxId, messageId) {
    ChatRepo.updateMessage(
        chatBoxId: chatBoxId,
        messageId: messageId,
        updatedData: {
          'messageType' : MessageType.deleted.name,
          'messageBody': 'Message was unsent!',
          'massageFileUrl':''
        }
    );}

  void updateUserProfile ({required String userId , required  Map<String, dynamic>  data }){
    print("updata data : $userId");
    ChatRepo.updateUserDate(userId, data);
   }


  Stream<FireBaseUserModel?> getUserBYIdStream(String userId) {
    return ChatRepo.getFireBaseUsersIdStream(userId);
  }
  Future<FireBaseUserModel?> getUserBYIdOInOneTime(String userId) {
    return ChatRepo.getFireBaseUsersIdOneTime(userId);
  }


  Stream<List<MessageModel>> getChatStream(chatBoxId) {
    Stream<List<MessageModel>> messageStream = ChatRepo.getOrderedChatsModelList(chatBoxId);
    print('message Stream is : ${messageStream}');
    return messageStream;
  }


  void updateReadStatus({
    chatBoxId,
    messageId,
  }) {
    ChatRepo.updateMessage(
        chatBoxId : chatBoxId,
        messageId:   messageId,
        updatedData : {'readStatus': ReadStatues.read.name}
    );
  }


  Future<bool> pickImage(ImageSource imageSource) async {
    try {
      rXfile.value = null;
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        rXfile.value = File(pickedFile.path);
        print('Image path: ${rXfile.value?.path}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error picking image: $e');
      return false;
    }
  }


  Future<File?> pickDocFile({
    FileType fileType = FileType.custom,
    List<String>? allowedExtensions,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        File pickedFile = File(result.files.single.path!);
        return pickedFile;
      } else {
        print('No file selected.');
        return null;
      }
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }

  Future<FireBaseUserModel?> getDataForInBoxTile(ChatMetadataModel chatMateDataModel) async {
    try {
      ChatMetadataModel matadata = chatMateDataModel;

        if(matadata.chatType == ChatType.direct.name){
          String currentUserId =  senderId;
          String userId  = matadata.members.where((id) => id != currentUserId ).first ;
          print("User ID: $userId");

          // Fetch the user data and emit it
          /// If it direct chat then use user id to find it data
        return  await getUserBYIdOInOneTime(userId);
        }else{
          /// If it group chat then use chatId  to find it data in profile collection
          return  await getUserBYIdOInOneTime(matadata.chatId);

      }
    }catch (e) {
      // TODO
      print('++++++++++++++++++++++++================ERROR => $e  ============================== ');
    return null;
    }
    return null;
  }


  Future<bool> pickFile() async {
    File? pickedFile = await pickDocFile(
        fileType: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'xlsx']
    );

    if (pickedFile != null) {
      rXfile.value = pickedFile;
      print('Resume PDF path: ${rXfile.value!.path}');
      return true;
    }
    return false;
  }

  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      // Handle permission denial
      return false;
    }
  }

  Future<void> downloadFile(String firebaseFilePath, String localFileName, int index) async {
    try {
      loadingStates[index] = true; // Get the download URL from Firebase Storage

      bool permissionGranted = await requestStoragePermission();
      if (!permissionGranted) {
        print('Storage permission denied');
        return;
      }
      final Uri url = Uri.parse(firebaseFilePath);

      // Perform the HTTP GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Get the local directory to save the file
        Directory downloadDirectory = await getDownloadDirectory();

        final localFilePath = '';
            '${downloadDirectory.path}/$localFileName';

        // Write the file to the local storage
        final file = File(localFilePath);
        await file.writeAsBytes(response.bodyBytes);

        print('File downloaded to: $localFilePath');
        CustomSnackbar.show(
          title: 'File Downloaded,',
          message: '',
          backgroundColor: AppColors.positiveGreen.withOpacity(.5),
          iconData: Icons.check_circle,
          iconColor: AppColors.positiveGreen,
          messageTextColor: AppColors.black,
          messageTextList: ['File Downloading failed'],
        );
        loadingStates[index] = false;        // Get the download URL from Firebase Storage

      } else {
        CustomSnackbar.show(
          title: AppStrings.downloadFailedText.tr,
          message: AppStrings.fileDownloadFailedText.tr,
          backgroundColor: AppColors.negativeRed.withOpacity(.5),
          iconData: Icons.error,
          iconColor: AppColors.negativeRed,
          messageTextList: ['${AppStrings.fileDownloadFailedText.tr} with status code ${response.statusCode}'],
          messageTextColor: AppColors.black,
        );
        loadingStates[index] = false;        // Get the download URL from Firebase Storage

        print('Failed to download file. HTTP status code: ${response.statusCode}');
      }
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.downloadFailedText.tr,
        message: AppStrings.fileDownloadFailedText.tr,
        backgroundColor: AppColors.negativeRed.withOpacity(.5),
        iconData: Icons.error,
        iconColor: AppColors.negativeRed,
        messageTextList: [AppStrings.fileDownloadFailedText.tr,],
        messageTextColor: AppColors.black,
      );
      loadingStates[index] = false;        // Get the download URL from Firebase Storage

      print('Error downloading file: $e');
    }
  }


  // Track message delete state
  final RxSet<int> selectedMessages = <int>{}.obs;

  void toggleMessageSelection(int index) {
    if (selectedMessages.contains(index)) {
      selectedMessages.remove(index);
    } else {
      selectedMessages.clear();
      selectedMessages.add(index);
      HapticFeedback.mediumImpact();
    }
  }

  bool isMessageSelected(int index) {
    return selectedMessages.contains(index);
  }

  void deleteMessage(String chatBoxId, String messageId, int index) {
    // Perform delete operation (API call or local database update)
    unSendMessage(chatBoxId, messageId);
    // Remove the message from the selected set
    selectedMessages.remove(index);
  }


  Stream<List<ChatMetadataModel>> getUserInbox(){
    print('$senderId');
    return ChatRepo.getUserInbox(senderId)
        .map((snapshot){
          print("---------------------${snapshot.size}");
      return snapshot.docs.map((document){
        print("---------------------${document.id}");
        return ChatMetadataModel(
            chatId: document.get('chatId'),
            chatType: document.get('chatType'),
            members:document.get('members'),
          lastMessage: document.get('lastMessage'),
          lastMessageTime: document.get('lastMessageTime'),
        );
      }).toList() ;
    });
  }
}

