import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final double borderRadius;
  final IconData? iconData;
  const CustomCachedImage({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.borderRadius, this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: AppColors.textGrey.withOpacity(0.2),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => CachedImageWithShimmer(
            height: height,
            width: width,
            borderRadius: borderRadius,
          ),
          errorWidget: (context, url, error) => Icon(iconData ?? Icons.error, color: Colors.blue,),
        ),
      ),
    );
  }
}

class CachedImageWithShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  const CachedImageWithShimmer({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
          width: width,
          height: height,
        ),
      ),
    );
  }
}