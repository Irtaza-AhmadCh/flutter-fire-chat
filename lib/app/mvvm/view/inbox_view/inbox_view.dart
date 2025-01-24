import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_fire_chat/app/custom_widgets/custom_cached_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../custom_widgets/custom_app_bar.dart';
import '../../../custom_widgets/custom_tabbar.dart';
import '../../../custom_widgets/inbox_tile.dart';
import '../../../custom_widgets/user_tile.dart';
import '../../model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import '../../model/firebase_user_profile_model/firebase_user_model.dart';
import '../../view_model/chat_controller/chat_controller.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> with TickerProviderStateMixin {
  TabController?  tabController;
  final ChatController chatController = Get.find();

  int selectedIndex  = 0;

  final List<Tab> tabsList = [
    Tab(text: "My Chats"),
    Tab(text: "All Users"),
  ];

  @override
  void initState() {
    tabController = TabController(
      length: tabsList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          toolbarHeight: 80.h,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 18.w,
          elevation: 2,

          shadowColor: AppColors.black,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "👋 Hello!",
                style: AppTextStyles.customText18(fontWeight: FontWeight.w500),
              ),
              Text(
                "Developer",
                style: AppTextStyles.customText28(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Container(
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2.5.sp)
                ),
                child: CustomCachedImage(height: 40.sp, width: 40.sp, imageUrl: '', borderRadius: 200.sp)
            ),
            10.w.width
          ]
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
          10.h.height,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              border: Border.all(color: AppColors.transparent),
              color: Colors.transparent,
            ),
            child: TabBar(
              isScrollable: false,
              tabs: tabsList.map((tab) {
                selectedIndex =  tabController!.index;
                int index = tabsList.indexOf(tab, 0);
                bool isSelected = index == selectedIndex ;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (isSelected)
                          ? Colors.transparent // Remove border for selected tab
                          : AppColors.black.withOpacity(.2), // Border color for unselected tab
                    ),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Tab(
                    text: tabsList[index].text,
                  ).paddingSymmetric(horizontal: 10.w),
                );
              }).toList(),
              controller: tabController,
              indicatorColor: AppColors.primary.withOpacity(0.15),
              labelColor: AppColors.primary,
              labelPadding: EdgeInsets.symmetric(horizontal: 4.sp),
              enableFeedback: false,
              splashFactory: NoSplash.splashFactory,
              overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: AppColors.transparent,
              unselectedLabelColor: AppColors.black,
              labelStyle: AppTextStyles.customText14(color: AppColors.black),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                border: Border.all(color: AppColors.primary),
                color: AppColors.primary.withOpacity(0.1),
              ),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ).paddingVertical(6.sp).paddingHorizontal(4.sp),
          ),
          10.h.height,
          Expanded(
            child: TabBarView(
              controller: tabController,
                children: [
              StreamBuilder<List<ChatMetadataModel>>(
                  stream: chatController.getUserInbox(),
                  builder: (BuildContext context, AsyncSnapshot<List<ChatMetadataModel>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Center(child: Text('No Message'));
                    } else {
                      return ListView.builder(
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
                      );
                    }
                  }),
              FutureBuilder<List<FireBaseUserModel>>(
                  future: chatController.getAllFirebaseUsers(),
                  builder: (BuildContext context, AsyncSnapshot<List<FireBaseUserModel>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Center(child: Text('No User'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final FireBaseUserModel user = snapshot.data![index];
                          print(user.userEmail);
                          return  UserTile(
                            currentUserId: chatController.senderId,
                            title: user.userName,
                            imgUrl:  user.profileImage,
                            subtitle: user.userEmail,
                            onTap: () {
                              chatController.initChatWithUser(user.userAppId ?? '');
                            },
                          );
                        },
                      );
                    }
                  }),
            ]
            ),
          ),

        ],
      ).paddingHorizontal(18.w),
    );
  }
}



