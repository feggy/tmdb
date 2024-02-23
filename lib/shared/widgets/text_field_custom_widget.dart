import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/shared/themes/colors.dart';
import 'package:tmdb/shared/themes/texts.dart';
import 'package:tmdb/shared/utils/validator.dart';
import 'package:tmdb/shared/widgets/button_child_custom_widget.dart';

class TextFieldCustomWidget extends StatefulWidget {
  const TextFieldCustomWidget({
    super.key,
    this.label,
    this.hintText,
    this.margin,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.onTap,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.focusNode,
    this.onEditingComplete,
    this.onSaved,
    this.fillColor,
    this.contentPadding,
    this.borderCircular,
    this.labelWidget,
    this.labelStyle,
    this.hintStyle,
    this.focusBorderColor,
    this.suffixIcon,
    this.autofocus = false,
    this.style,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.enableSuggestions = true,
  });

  final String? label;
  final String? hintText;
  final EdgeInsets? margin;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final Function(String?)? onSaved;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final double? borderCircular;
  final Widget? labelWidget;
  final TextStyle? labelStyle;
  final Color? focusBorderColor;
  final bool autofocus;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final bool enableSuggestions;

  @override
  State<TextFieldCustomWidget> createState() => _TextFieldCustomWidgetState();
}

class _TextFieldCustomWidgetState extends State<TextFieldCustomWidget> {
  var clearTextVisibility = false;
  var obscureTextPassword = false;

  @override
  void initState() {
    super.initState();
    obscureTextPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.label != null
                  ? Text(
                      widget.label!,
                      style: widget.labelStyle ?? labelTextFormStyle,
                    )
                  : const SizedBox(),
              (widget.labelWidget ?? const SizedBox())
            ],
          ),
          widget.label != null ? const SizedBox(height: 10) : const SizedBox(),
          TextFormField(
            style: widget.style ?? fieldTextFormStyle,
            obscureText: obscureTextPassword,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            onChanged: (s) {
              if (widget.onChanged != null) widget.onChanged!(s);

              setState(() {
                if (s.isNotEmpty) {
                  clearTextVisibility = true;
                } else {
                  clearTextVisibility = false;
                }
              });
            },
            validator:
                widget.validator ?? (s) => Validator.validateEmpty(s ?? ''),
            onFieldSubmitted: widget.onFieldSubmitted,
            autovalidateMode: widget.autovalidateMode,
            readOnly: widget.enabled == false,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            autocorrect: false,
            onEditingComplete: widget.onEditingComplete,
            onSaved: widget.onSaved,
            autofocus: widget.autofocus,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines ?? 1,
            maxLength: widget.maxLength,
            textCapitalization: widget.textCapitalization,
            enableSuggestions: widget.enableSuggestions,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? greyNeutral30Color,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? hintTextFormStyle,
              errorStyle: errorTextFormStyle,
              errorMaxLines: 2,
              prefixIconConstraints: const BoxConstraints(maxWidth: 40),
              suffixIcon: widget.suffixIcon ??
                  (widget.obscureText
                      ? ButtonChildCustomWidget(
                          onPressed: () {
                            setState(() {
                              obscureTextPassword = !obscureTextPassword;
                            });
                          },
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              obscureTextPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20,
                              color: greyNeutral70Color,
                            ),
                          ))
                      : widget.controller?.text.isEmpty ?? false
                          ? const SizedBox()
                          : (clearTextVisibility && widget.enabled
                              ? ButtonChildCustomWidget(
                                  child: const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: greyNeutral70Color,
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.controller?.text = '';
                                    setState(() {
                                      clearTextVisibility = false;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged!('');
                                    }
                                  },
                                )
                              : const SizedBox())),
              prefixIcon: widget.prefixIcon,
              prefix: const SizedBox(width: 16),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: borderTextFormColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderCircular ?? 10),
                borderSide: const BorderSide(
                  color: borderTextFormColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderCircular ?? 10),
                borderSide: BorderSide(
                  color: !widget.enabled
                      ? borderTextFormColor
                      : widget.focusBorderColor ?? primaryColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderCircular ?? 10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
