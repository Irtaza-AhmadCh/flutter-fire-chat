import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class Utils {

  // /// Convert Latitude and Longitude to an Address
  // Future<String?> convertLatLngToAddress(double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
  //     if (placemarks.isNotEmpty) {
  //       final place = placemarks.first;
  //       return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //     }
  //     return "No address found for these coordinates.";
  //   } catch (e) {
  //     print("Error converting LatLng to Address: $e");
  //     return null;
  //   }
  // }
  //
  // static String formatDate(DateTime? date) {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   return formatter.format(date ?? DateTime.now());
  // }


  // /// Convert an Address to Latitude and Longitude
  // Future<Map<String, double>?> convertAddressToLatLng(String address) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(address);
  //     if (locations.isNotEmpty) {
  //       final location = locations.first;
  //       return {
  //         "latitude": location.latitude,
  //         "longitude": location.longitude,
  //       };
  //     }
  //     return null; // No coordinates found
  //   } catch (e) {
  //     print("Error converting Address to LatLng: $e");
  //     return null;
  //   }
  // }


  static String convertDate(String isoDate) {
    // Parse the ISO 8601 date string
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }
  static String formatTime(String isoDateString) {
    // Parse the ISO date string
    DateTime dateTime = DateTime.parse(isoDateString);

    // Format it to "hh:mm a" (e.g., "09:10 PM")
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
  }


  static showCustomDialog(context, Widget body) {
    showDialog(
        barrierColor: Colors.black.withOpacity(0.6),
        barrierDismissible: false,
        context: context,

        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.sp)),
            child: body,
          );
        });
  }


  // static showPickFileOptionsDialog(
  //     BuildContext context, {
  //       required VoidCallback onFileTap,
  //       required VoidCallback onCameraTap,
  //     }) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Center(
  //       child: Material(
  //         color: AppColors.transparent,
  //         child: Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20.sp),
  //               color: AppColors.white
  //           ),
  //           padding: EdgeInsets.all(18.sp),
  //           margin: EdgeInsets.symmetric(horizontal: 15.sp),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("Pick Document", style: AppTextStyles.customText26(color: Colors.black, fontWeight: FontWeight.w600),),
  //               10.h.height,
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: JumpCustomButton(
  //                       height: 50.sp,
  //                       icon: Icon(CupertinoIcons.camera_fill, color: AppColors.white, size: 15.sp,),
  //                       bgColor: AppColors.secondary,
  //                       title: 'Camera',
  //                       onPressed: onCameraTap,
  //                       textStyle: AppTextStyles.customText12(
  //                         color: AppColors.white,
  //                       ),
  //                     ),
  //                   ),
  //               10.w.width,
  //               Expanded(
  //                 child: JumpCustomButton(
  //                   height: 50.sp,
  //                   bgColor: AppColors.negativeRed,
  //                   title: 'Storage',
  //                   onPressed: onFileTap,
  //                   icon: Icon(CupertinoIcons.doc_text_fill, color: AppColors.white, size: 15.sp,),
  //
  //                   textStyle: AppTextStyles.customText12(
  //                     color:  AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //                 ],
  //               ),
  //
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static Future<void> showCustomBottomSheet(context , Widget body, {bool? isScrollControlled, bool? useRootNavigator}) async {
    await showModalBottomSheet(
      isScrollControlled: isScrollControlled ?? true,
      useRootNavigator: useRootNavigator ?? true,
      backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.sp), topRight: Radius.circular(30.sp),)),
        context: context, builder: (context){
      return body;
    });
  }

  static showPickImageOptionsDialog(
    BuildContext context, {
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: onCameraTap,
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalleryTap,
            child: const Text("Gallery"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }


}