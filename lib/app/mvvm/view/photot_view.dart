
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../config/app_colors.dart';


class PhotoViewer extends StatefulWidget {
  final String url;

  const PhotoViewer({super.key, required this.url});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  // String? imageUrl;
  PhotoViewControllerValue photoViewControllerValue =
  const PhotoViewControllerValue(position: Offset.zero, scale: 0, rotation: 0, rotationFocusPoint: Offset.zero);

  @override
  void initState() {
    super.initState();
    // imageUrl = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.5),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 18.sp,
                )),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SizedBox(
          height: ScreenUtil().screenHeight - 100,
          width: ScreenUtil().screenWidth,
          child: Hero(
            tag: widget.url ?? 'image',
            child: PhotoView(
              minScale: 0.1,
              maxScale: 5.0,
              wantKeepAlive: true,
              loadingBuilder: (context, event) {
                return const Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.primary,
                    ));
              },
              enableRotation: false,
              initialScale: PhotoViewComputedScale.covered,
              imageProvider: NetworkImage(widget.url ??
                  'https://cdn.pixabay.com/photo/2022/08/24/05/44/duck-7406987_640.jpg'), // Replace with your image provider (FileImage, NetworkImage, etc.)
            ),
          ),
        ),
      ),
    );
  }
}
