import 'package:flutter/material.dart';
import 'package:tmdb/shared/themes/texts.dart';

class TextCustomWidget extends StatelessWidget {
  const TextCustomWidget({
    super.key,
    required this.text,
    this.margin,
    this.style,
    this.onTap,
    this.alignment,
    this.textAlign,
    this.maxLines,
    this.height,
    this.width,
    this.overflow,
    this.padding,
    this.visible = true,
  });

  final String text;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Function()? onTap;
  final AlignmentGeometry? alignment;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final double? width;
  final TextOverflow? overflow;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          margin: margin,
          padding: padding,
          child: Text(
            text,
            style: style ?? blackTextStyle,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLines,
          ),
        ),
      ),
    );
  }
}
