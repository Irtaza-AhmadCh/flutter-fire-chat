import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomSnackbar {
  static void show({
    required String? title,
    required String? message,
    required Color? backgroundColor,
    required IconData? iconData,
    required Color? iconColor,
    required List<String>? messageTextList, // Accept a list of messages
    required Color? messageTextColor,
  }) {
    Get.snackbar(
      title ?? '',
      '',
      backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.8),
      icon: iconData != null ? Icon(iconData, color: iconColor ?? Colors.white, size: 24) : null,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 10,
      borderWidth: 2,
      borderColor: const Color(0xffFF9F20).withOpacity(0.2),
      animationDuration: const Duration(milliseconds: 370),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      messageText: Column( // Display each error message in a column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: messageTextList?.map((msg) => Text(
          msg,
          style: AppTextStyles.customText12(color: messageTextColor),
        )).toList() ?? [],
      ),
      titleText: Text(
        title ?? '',
        style: AppTextStyles.customText20(color: AppColors.black, fontWeight: FontWeight.w500),
      ),
      boxShadows: [
        const BoxShadow(color: AppColors.secondary),
        const BoxShadow(color: AppColors.primary),
      ],
    );
  }
}
