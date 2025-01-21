import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../custom_widgets/custom_app_bar.dart';
import '../../../custom_widgets/inbox_tile.dart';
import '../../model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import '../../model/firebase_user_profile_model/firebase_user_model.dart';
import '../../view_model/chat_controller/chat_controller.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  final ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: 0.width,
        title: 'Message',
        trailing: Icon(
          Icons.more_vert,
          color: AppColors.black,
          size: 20.sp,
        ).paddingRight(10.w),
      ),
      body: Column(
        children: [
          // BarnYardCustomField(
          //   prefixIcon: Icon(
          //     Icons.search,
          //     color: AppColors.borderColor,
          //   ),
          //   hintText: 'Search message',
          //   hintColor: AppColors.borderColor,
          // ),
          StreamBuilder<List<ChatMetadataModel>>(
              stream: chatController.getUserInbox(),
              builder: (BuildContext context, AsyncSnapshot<List<ChatMetadataModel>> snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Expanded(
                    child: Text('No Message')
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final chat = snapshot.data![index];
                        return FutureBuilder(
                            future: chatController.getDataForInBoxTile(chat),
                            builder: (BuildContext context, AsyncSnapshot<FireBaseUserModel?>userSnapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    'Error: ${userSnapshot.error}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: 0.width,
                                );
                              } else if (userSnapshot.data == null || snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text('N/A'),
                                );
                              } else {
                                return InboxTile(
                                  currentUserId: chatController.senderId,
                                  chatBoxId: chat.chatId,
                                  time: chat.lastMessageTime,
                                  title: userSnapshot.data?.userName,
                                  imgUrl:  userSnapshot.data?.profileImage,
                                  subtitle: chat.lastMessage,
                                  onTap: () {
                                    chatController.initChatWithUser(userSnapshot.data?.userAppId ?? '');
                                  },
                                );
                              }
                            });
                      },
                    ),
                  );
                }
              })
        ],
      ).paddingHorizontal(18.w),
    );
  }
}
