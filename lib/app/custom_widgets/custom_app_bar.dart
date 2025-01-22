
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fire_chat/app/config/padding_extension.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';
import '../config/app_text_style.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? toolBarHeight;
  final Color? backButtonColor;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  final Color shadowColor;
  final Color titleColor;
  final Widget? trailing;
  final Widget? leading;
  final bool shouldAddBG;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double? titleSpacing;
  final double? titleFontSize;
  final bool shouldAddBackButton;
  final SystemUiOverlayStyle? statusBarStyle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingWidth,
    this.onBackPressed,
    this.centerTitle = true,
    this.elevation = 1.0,
    this.backgroundColor = AppColors.secondary,
    this.shadowColor = Colors.black,
    this.titleColor = Colors.white,
    this.trailing,
    this.leading,
    this.shouldAddBG = false,
    this.statusBarStyle,
    this.titleWidget,
    this.titleSpacing,
    this.backButtonColor,
    this.toolBarHeight,
    this.shouldAddBackButton = true, this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolBarHeight ?? 80.h,
      scrolledUnderElevation: 0.0,
      systemOverlayStyle: statusBarStyle ??
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 50.w,
      elevation: elevation,
      titleSpacing: titleSpacing,
      shadowColor: shadowColor.withOpacity(0.3),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: shouldAddBackButton ? (leading ??
          BarnYardBackButton(
            bgColor: backButtonColor ?? null,
          ).paddingLeft(15.w).paddingTop(10.h).paddingBottom(10.h).paddingRight(0.w)) : null,
      flexibleSpace: shouldAddBG
          ? Image(
        image: const AssetImage(
          'AppAssets.headerBg',
        ),
        width: ScreenUtil().screenWidth,

        fit: BoxFit.fill,
        alignment: Alignment.bottomCenter,
      )
          : null,
      title: title != null
          ? Text(
        title ?? '',
        style: AppTextStyles.customText(
          fontSize: titleFontSize ?? 27.sp,
          letterSpacing: -0.5,
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
      )
          : titleWidget,
      actions: [
        if (trailing != null) trailing!,
        10.w.width,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight );
}


class BarnYardBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? bgColor;
  final IconData? icon;
  const BarnYardBackButton({super.key, this.onTap, this.icon,this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : (){
        HapticFeedback.mediumImpact();

        if(onTap == null){
          Navigator.pop(context);

        }else{
          onTap!();
        }
      },
      child: Icon(Icons.arrow_back_ios_new_sharp , size: 24.sp,),
    );
  }
}
