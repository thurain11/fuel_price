import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  final int? memCacheHeight;
  final int? memCacheWidth;
  BoxFit? fit;
  String? errImg;
  NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.fit = BoxFit.cover,
    this.memCacheHeight,
    this.memCacheWidth,
    this.errImg,
    this.borderRadius = 8,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        color: Theme.of(context).cardColor,
        width: width,
        height: height,
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        placeholder: (context, url) =>
            ShimmerLoadingWidget(width: width, height: height),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: errImg == null
                ? Icon(
                    Icons.image_outlined,
                    size: iconSize,
                    color: Colors.grey.shade300,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      errImg ?? '',
                      width: iconSize, // ✅ control size here
                      height: iconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
