import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';
import '../mvvm/model/message_model/message_model.dart';
import '../mvvm/view_model/chat_controller/chat_controller.dart';
import 'custom_cached_image.dart';


class MessageBubble extends StatefulWidget {
  final String chatBoxId;
  final int index;
  final String userId;
  final  MessageModel message;

  const MessageBubble({
    super.key,
    required this.message,
    required this.userId,
    required this.chatBoxId,
    required this.index,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final ChatController controller = Get.find();
  String? fileExtension;
  late bool isMe;
  List<String> imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

  @override
  void initState() {
    super.initState();
    if (widget.message.messageSenderId != widget.userId) {
      controller.updateReadStatus(chatBoxId: widget.chatBoxId, messageId: widget.message.messageId);
    }
    fileExtension = widget.message.messageFileType.toString();
    isMe = widget.message.messageSenderId == widget.userId;
  }

  @override
  Widget build(BuildContext context) {

    return

      Obx(
          ()=> GestureDetector(
            onTap: (){
              controller.selectedMessages.remove(widget.index);
            },
            child: Container(
            color: controller.isMessageSelected(widget.index) ? AppColors.primary.withOpacity(.5) : Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if ( controller.isMessageSelected(widget.index) && widget.message.messageSenderId == widget.userId && widget.message.messageType != MessageType.deleted.name)
                  GestureDetector(
                    onTap: () {
                      controller.deleteMessage(
                        widget.chatBoxId,
                        widget.message.messageId,
                        widget.index,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(.4),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10.sp),
                      child: Icon(
                        CupertinoIcons.delete_solid,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ).paddingLeft(20.w),
                Expanded(
                  child: Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        6.height,
                        GestureDetector(

                          onLongPress:
                          (widget.message.messageSenderId == widget.userId && widget.message.messageType != MessageType.deleted.name)
                              ? () {
                            controller.toggleMessageSelection(widget.index);
                          }
                              : null,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(15),
                                topRight: const Radius.circular(15),
                                bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
                                bottomRight: isMe ? Radius.zero : const Radius.circular(15),
                              ),
                              color: isMe ? AppColors.primaryLight : AppColors.darkBrownColor.withOpacity(.09),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((widget.message.messageFileUrl?.isNotEmpty ?? false)) ...[
                                  (imageExtensions.contains(fileExtension?.toLowerCase()))
                                      ? Hero(
                                    tag: widget.message.messageFileUrl ?? '',
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.to(() => PhotoViewer(
                                        //   url: widget.message.messageFileUrl ?? '',
                                        // ));
                                      },
                                      child: CustomCachedImage(
                                        height: 100.h,
                                        width: double.infinity,
                                        imageUrl: widget.message.messageFileUrl ?? '',
                                        borderRadius: 10.sp,
                                      ),
                                    ),
                                  )
                                      : Container(
                                    height: 100.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(10.sp),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.insert_drive_file_rounded,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 38.sp,
                                      ),
                                    ),
                                  ),
                                ],
                                5.h.height,
                                Row(
                                  // Changing Cross
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (widget.message.messageType == MessageType.deleted.name) ...[
                                      Icon(
                                        Icons.block,
                                        size: 20.sp,
                                        color: isMe ? AppColors.white : AppColors.textBlueColor,
                                      ),
                                      4.w.width,
                                    ],
                                    Expanded(
                                      child:
                                      ReadMoreText(
                                        widget.message.messageBody,
                                        trimMode: TrimMode.Line,
                                        trimLines: 4,
                                        colorClickableText: Colors.pink,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: '...Show less',
                                        style: AppTextStyles.customText(
                                          color:  AppColors.black.withOpacity(0.5) ,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                        lessStyle: AppTextStyles.customTextLexend(
                                          color:isMe ?   AppColors.white: AppColors.black.withOpacity(0.5) ,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp,
                                        ),
                                        moreStyle: AppTextStyles.customTextLexend(
                                          color:isMe ?   AppColors.white: AppColors.black.withOpacity(0.5) ,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                    if ((widget.message.messageFileUrl?.isNotEmpty ?? false))
                                      (
                                          controller.loadingStates[widget.index] ?? false
                                      )
                                          ? CupertinoActivityIndicator(
                                        color: AppColors.black.withOpacity(0.5),
                                      )
                                          : GestureDetector(
                                        onTap: () {
                                          controller.downloadFile(
                                              widget.message.messageFileUrl ?? '',
                                              'file_${DateTime.now().millisecondsSinceEpoch.toString()}${widget.message.messageFileType}'
                                                  .trim(),
                                              widget.index);
                                        },
                                        child: Icon(
                                          Icons.download_for_offline_outlined,
                                          color:isMe ? AppColors.white : AppColors.textBlueColor,
                                          size: 20.sp,
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ).paddingVertical(5.h),
                          ),
                        ),
                        Text(


                          controller.formatTimestampToTime(widget.message.messageSendTime ?? Timestamp.now()),
                          style: AppTextStyles.customTextLexend(
                            fontSize: 12.sp,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        6.h.height,
                      ],
                    ).paddingHorizontal(8.w),
                  ),
                ),
              ],
            ),
                    ),
          ).paddingBottom(3.h),
      );

  }
}


