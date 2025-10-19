import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 import 'package:qeema_task/src/core/extension/string.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    this.borderRadius,
    this.link,
    this.width,
    this.height,
    this.fit,
    this.customBorder,
  });

  final double? borderRadius;
  final String? link;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadiusGeometry? customBorder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: customBorder ?? BorderRadius.circular(borderRadius ?? 8),
      child: (!link.nullOrEmpty && link!.trim().isNotEmpty)
          ? CachedNetworkImage(
              imageUrl: link!,
              width: width ?? 30,
              height: height ?? 30,
              fit: fit,
              placeholder: (context, url) {
                return Icon(Icons.downloading_outlined);
              },
              errorWidget: (context, url, error) {
                return Padding(
                  padding: const EdgeInsetsDirectional.all(30),
                  child: Icon(Icons.error),
                );
              },
            )
          : SizedBox(),
    );
  }
}
