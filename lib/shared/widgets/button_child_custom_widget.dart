import 'package:flutter/material.dart';

class ButtonChildCustomWidget extends StatelessWidget {
  const ButtonChildCustomWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.margin,
    this.padding,
  });

  final Widget child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: buttonWidget(),
    );
  }

  Widget buttonWidget() {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  }
}
