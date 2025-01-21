import 'package:flutter/material.dart';
import 'package:flutter_fire_chat/app/config/sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../config/app_text_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.minLines,
    this.fieldsTextAlign,
    this.fieldsInputType,
    this.hintFontWeight,
    this.hintColor,
    this.hintTextOverflow,
    this.isReadOnly,
    this.hintTextFontFamily,
    this.hintTextFontSize,
    this.contentPadding,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.focusErrorBorderColor,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.initialValue,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onChanged,
    this.onPressed,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusErrorBorder,
    this.labelText,
    this.labelColor,
    this.labelFontWeight,
    this.labelTextOverflow,
    this.labelTextFontFamily,
    this.labelTextFontSize,
    this.filled,
    this.fillColor,
    this.textColor,
    this.validationText,
    this.labelTitle,
    this.titleWidget,
    this.isRequired = false,
    this.keyboardType,
    this.enabled = true,
    this.onTap, this.labelTitleSize, this.cursorColor, // Add onTap to trigger when the field is tapped
  });
 final Color? cursorColor;
  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextAlign? fieldsTextAlign;
  final TextInputType? fieldsInputType;
  final bool? obscureText;
  final FontWeight? hintFontWeight;
  final Color? hintColor;
  final bool? isReadOnly; // Check if the field is read-only
  final TextOverflow? hintTextOverflow;
  final String? hintTextFontFamily;
  final double? hintTextFontSize;
  final String? labelText;
  final Color? labelColor;
  final FontWeight? labelFontWeight;
  final TextOverflow? labelTextOverflow;
  final TextInputType? keyboardType;
  final String? labelTextFontFamily;
  final double? labelTextFontSize;
  final EdgeInsets? contentPadding;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? focusErrorBorderColor;
  final double? focusedBorder;
  final double? enabledBorder;
  final double? errorBorder;
  final double? disabledBorder;
  final double? focusErrorBorder;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? titleWidget;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Function(String)? onChanged;
  final VoidCallback? onPressed;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final String? labelTitle;
  final bool isRequired;
  final bool enabled;
  final double? labelTitleSize;
  final VoidCallback? onTap; // New onTap callback for custom action

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelTitle != null)
          Row(
            children: [
              Text(
                labelTitle ?? '',
                style:  AppTextStyles.customText(
                  fontSize: labelTitleSize ?? 14.sp,
                  color: labelColor ?? AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired)
                Text(
                  '*',
                  style: AppTextStyles.customText14(
                    color: AppColors.secondary,
                  ),
                ),
            ],
          ),
        if (titleWidget != null) titleWidget!,
        4.h.height,
        TextFormField(
          cursorColor: cursorColor ?? AppColors.primary,
          enabled: enabled,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            } else if (value == null || value.isEmpty) {
              return validationText ?? AppStrings.thisFieldCantBeEmptyText.tr;
            }
            return null;
          },
          style: AppTextStyles.customText16(
            color: textColor ?? AppColors.black,
          ),
          initialValue: initialValue,
          textAlign: fieldsTextAlign ?? TextAlign.start,
          maxLines: maxLines ?? 1,
          controller: controller,

          minLines: minLines ?? 1,
          readOnly: isReadOnly ?? false, // Make field read-only based on isReadOnly property
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          obscuringCharacter: "•",
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.customInterTextStyle(
              fontSize: hintTextFontSize ?? 12.sp,
              fontWeight: hintFontWeight ?? FontWeight.normal,
              color: hintColor ?? const Color(0xffADB3B7),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            floatingLabelStyle: const TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: filled ?? true,
            fillColor: fillColor ?? AppColors.transparent,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffE6E7E9),
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            prefixIconColor: prefixIconColor,
            suffixIconColor: suffixIconColor,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor ?? AppColors.primary
              ),
              borderRadius: BorderRadius.circular(focusedBorder ?? 30.sp,)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedBorder ?? 30.sp,),
              borderSide: BorderSide(
                color: enabledBorderColor ?? AppColors.borderColor,
              )
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedBorder ?? 30.sp,),
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.red,
              )
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedBorder ?? 30.sp,),
              borderSide: BorderSide(
                color: disabledBorderColor ?? AppColors.borderColor,
              )
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(focusedBorder ?? 30.sp,),
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.red,
              )
            ),
            errorMaxLines: 2,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}