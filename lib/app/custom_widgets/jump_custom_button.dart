import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isGradientEnabled;
  final Color? bgColor;
  final Color? borderColor;
  final GlobalKey? textKey;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
     this.gradient,
    this.borderRadius ,
    this.height,
    this.width ,
    this.textStyle, this.icon, this.isGradientEnabled = false, this.bgColor, this.borderColor, this.textKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onPressed();
      },
      child: Container(
        height: height   ?? 58.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primary,
          gradient: !isGradientEnabled ? null : gradient ?? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.secondary
            ]
          ),
          border: Border.all(color: borderColor ?? AppColors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(icon!= null)
              icon!,
            if(icon!= null)
            6.width,
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              title,
              key: textKey,
              style: textStyle ??
                   AppTextStyles.customText16(
                    color: Colors.white,
                     fontWeight: FontWeight.w600
                  ),
            ),
          ],
        ),
      ),
    );
  }
}