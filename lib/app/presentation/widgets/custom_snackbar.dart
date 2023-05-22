import 'package:flutter/material.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class CustomSnackbar {

  static sucess({required String text,
    Color? textColor,
    Widget? icon,
    Color? color,
    required BuildContext context}){
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: text,
        backgroundColor: color ?? const Color(0xff00E676),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
        icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: icon ?? const Icon(
            Icons.sentiment_very_satisfied,
            color: Color(0x15000000),
            size: 50,
          ),
        )
      ),
    );
  }

  static error({required String text,
    Color? textColor,
    Widget? icon,
    Color? color,
    required BuildContext context}){
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: text,
        backgroundColor: color ?? const Color(0xffff5252),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
        icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: icon ?? const Icon(
            Icons.error_outline,
            color: Color(0x15000000),
            size: 50,
          ),
        )
      ),
    );
  }

  static info({required String text,
    Color? textColor,
    Widget? icon,
    Color? color,
    required BuildContext context}){
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: text,
        backgroundColor: color ?? const Color(0xff2196F3),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
        icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: icon ?? const Icon(
            Icons.sentiment_neutral,
            color: Color(0x15000000),
            size: 50,
          ),
        )
      ),
    );
  }
}