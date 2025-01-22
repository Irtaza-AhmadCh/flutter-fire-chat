
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/custom_app_bar.dart';
import 'package:flutter_fire_chat/app/custom_widgets/jump_custom_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../custom_widgets/custom_cached_image.dart';
import '../../../custom_widgets/message_bubble.dart';
import '../../model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import '../../model/firebase_user_profile_model/firebase_user_model.dart';
import '../../model/message_model/message_model.dart';
import '../../view_model/chat_controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String chatBoxId = '';
  String currentUserId = '';
  String receiverId = '';

  final ChatController chatController = Get.find();



  @override
  void dispose() {
    chatController.messageScrollController.removeListener(chatController.scrollListener);
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiverId = Get.arguments['receiverId'];
    currentUserId = Get.arguments['currentUserId'];
    chatBoxId = chatController.getChatBoxId(receiverId, currentUserId);
    chatController.messageScrollController.addListener(chatController.scrollListener);

    print("View Chat Id $chatBoxId recever idd $receiverId  and sender $currentUserId ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        backgroundColor: AppColors.primary,
        leading: 0.width,
        titleSpacing: 0,
        centerTitle: false,

        titleWidget:     FutureBuilder(
            future: chatController.getUserBYIdOInOneTime(receiverId),
            builder: (BuildContext context, AsyncSnapshot<FireBaseUserModel?> userSnapshot) {
              if (userSnapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${userSnapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (userSnapshot.data == null) {
                return 0.width;
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CustomCachedImage(
                        height: 45.sp,
                        width: 45.sp,
                        imageUrl: userSnapshot.data?.profileImage ??
                            "https://images.pexels.com/photos/4427543/pexels-photo-4427543.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                        borderRadius: 300.r,
                      ).paddingFromAll(2.sp),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      userSnapshot.data?.userName ?? "Albert Flores",
                      style: AppTextStyles.customText16(
                        color: AppColors.black,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
                ()=>chatController.isScrolled.value? GestureDetector(
                    onTap: (){
              chatController.scrollToBottom();
                    },
                    child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.arrow_downward_sharp , color: AppColors.white,).paddingFromAll(3.sp),
              ),
                  ) : 0.width
            ),
            80.h.height,
          ],
        ),
      body: Column(
        children: [

          10.h.height,
          Expanded(
            child: Column(
              children: [
                StreamBuilder(
                    stream: chatController.getChatStream(chatBoxId),
                    builder: (context, snapshot) {
                      chatController.isFirstMessage.value = snapshot.data == null;

                      if ((snapshot.data != null)) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    chatController.scrollToBottom();
    });}
                      print('${snapshot.data}');
                      if (snapshot.hasError) {
                        return Expanded(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                            child: CupertinoActivityIndicator(
                          color: AppColors.primary,
                        ));
                      }else if (snapshot.data == null && snapshot.hasData  ) {
                        return Expanded(
                            child: Text('Start Chat')
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            controller: chatController.messageScrollController,
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              MessageModel message = snapshot.data![index];
                              return MessageBubble(message: message, userId: chatController.senderId, chatBoxId: chatBoxId, index: index);
                            },
                          ),
                        );
                      }
                    }),
                Column(
                  children: [
                    15.h.height,
                    Row(
                      children: [
                        Expanded(
                          child: CustomField(
                            hintColor: AppColors.borderGrey,
                            hintText: 'Write Message',
                            controller: chatController.messageController,
                          ),
                        ),
                        10.w.width,
                        GestureDetector(
                          onTap: () {
                            chatController.sendChatWithImageMessage(
                                messageType: MessageType.text,
                                isFirstMessageOfChat:true ,
                                chatBoxId: chatBoxId,
                                recipientId: receiverId,
                                chatType: ChatType.direct
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Icon(
                            Icons.send,
                          size: 20.sp,
                            ).paddingRight(2.w)),
                          ),
                        ),
                      ],
                    ).paddingBottom(20.sp),
                  ],
                ),
              ],
            ).paddingHorizontal(15.w),
          ),
        ],
      ),
    );
  }
}
