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


class UserTile extends StatefulWidget {
  final String? imgUrl;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final String? currentUserId;


  const UserTile({super.key, this.imgUrl, this.title, this.subtitle, this.onTap,   this.currentUserId});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {

  final  ChatController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
