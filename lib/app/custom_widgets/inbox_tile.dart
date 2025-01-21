import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';
import '../mvvm/view/photot_view.dart';
import '../mvvm/view_model/chat_controller/chat_controller.dart';
import 'custom_cached_image.dart';


class InboxTile extends StatefulWidget {
  final String? imgUrl;
  final String? title;
  final String? subtitle;
  final Timestamp? time;
  final VoidCallback? onTap;
  final String? chatBoxId;
  final String? currentUserId;


  const InboxTile({super.key, this.imgUrl, this.title, this.subtitle, this.onTap, this.time,  this.chatBoxId,  this.currentUserId});

  @override
  State<InboxTile> createState() => _InboxTileState();
}

class _InboxTileState extends State<InboxTile> {
  
   final  ChatController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(widget.chatBoxId),
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                Get.to(PhotoViewer(url: widget.imgUrl ??'' ));
              },
              child: CustomCachedImage(
                height: 55.sp,
                width: 55.sp,
                imageUrl: widget.imgUrl ?? 'https://images.pexels.com/photos/29942641/pexels-photo-29942641/free-photo-of-charming-cottage-with-vibrant-bougainvillea.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
                borderRadius: 100.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title ?? 'Jim Cooper',
                        style: AppTextStyles.customText(
                          fontSize: 14.sp,
                          color: AppColors.textDarkBlueColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  4.h.height,
                  Text(
                    widget.subtitle ?? 'Hi , How are you',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.customText(
                      fontSize: 12.sp,
                      color: AppColors.borderColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  controller.formatTimestampToTime(widget.time ?? Timestamp.now()),
                  style: AppTextStyles.customText12(color:AppColors.borderColor, fontWeight: FontWeight.w400),
                ),4.h.height,
                UnreadMessageCount(unreadMessageCountStream: controller.getUnreadMessageCount(widget.chatBoxId ??"", widget.currentUserId ?? ''),)
              ],
            )
          ],
        ),
      ),
    );
  }
}


class UnreadMessageCount extends StatelessWidget {
  final Stream<int?> unreadMessageCountStream;

  const UnreadMessageCount({
    required this.unreadMessageCountStream,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: unreadMessageCountStream,
      builder: (context, countSnap) {
        if (countSnap.hasError || countSnap.data == null || countSnap.data == 0) {
          return SizedBox.shrink();
        }
        return Container(
          height: 15.sp,
          width: 15.sp,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              countSnap.data! < 100 ? countSnap.data.toString() : '99+',
              style: AppTextStyles.customText(
                fontSize: 8,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
