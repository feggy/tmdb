import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb/shared/themes/colors.dart';

class ImageNetworkCustomWidget extends StatelessWidget {
  const ImageNetworkCustomWidget({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.margin,
    this.border,
    this.padding,
    this.loadingWidget,
    this.loadError,
    this.shape = BoxShape.rectangle,
    this.svgColorFilter,
  });

  final String? imageUrl;
  final double width;
  final double? height;
  final BorderRadius borderRadius;
  final Widget? errorWidget;
  final BoxFit fit;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final Widget? loadingWidget;
  final Function(bool)? loadError;
  final BoxShape shape;
  final ColorFilter? svgColorFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        shape: shape,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Center(
          child: Container(
            padding: padding,
            child: _contentWidget(),
          ),
        ),
      ),
    );
  }

  Widget _contentWidget() {
    final isSvg = imageUrl?.endsWith('.svg') ?? false;

    if (isSvg) {
      return SvgPicture.network(
        imageUrl!,
        colorFilter: svgColorFilter,
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: imageUrl ?? '',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          loadingWidget ??
          Container(
            width: width,
            height: height,
            color: greyNeutral30Color,
          ),
      errorWidget: (context, url, error) {
        if (loadError != null) loadError!(true);
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: greyNeutral30Color,
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.image_not_supported_outlined,
                size: 30,
                color: Colors.grey,
              ),
            );
      },
    );
  }
}
