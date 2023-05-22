

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme_colors.dart';



class CustomButtom {

  static Widget custom({required String title, VoidCallback? onPressed,
    Color? color, Color? borderColor, IconData? icon, double? size,}){
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) => states.any((e) =>
                  e == MaterialState.disabled || e == MaterialState.error)
                    ? null : color ?? ThemeColors.priColor ,
          ),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
                (Set<MaterialState> states) => const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
                (Set<MaterialState> states) => RoundedRectangleBorder(
                    side: BorderSide(color: borderColor ?? Colors.transparent), //the outline color
                    borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
          minimumSize: MaterialStateProperty.resolveWith<Size?>(
                (Set<MaterialState> states) => const Size(0,0),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: 20,
          width: size,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              if(icon != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (title != '' ? 0 : 10)),
                  child: Icon(icon, size: 20, color: color == Colors.white ? ThemeColors.priColor : Colors.white,),
                ),
              if(icon != null && title != '')
                SizedBox(width: 10,),
              if(title != '')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (icon != null ? 0 : 10)),
                  child: Text(title,style: TextStyle(color: color == Colors.white ? ThemeColors.priColor : Colors.white), ),
                )
            ],
          ),
        )
    );
  }
}