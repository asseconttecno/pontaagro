
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'custom_buttom.dart';


class CustomAlert{

  static Future custom(BuildContext context, {String? title, Widget? img,  Color? color,
    Widget? body, Function? confirm, String? textConfirm, IconData? iconConfirm,
    bool fecharClique = true, String? textCancel, IconData? iconCancel, Function? cancel,
    bool quit = true}) async {

    await showDialog(
      context: context,
      barrierDismissible: fecharClique,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: title == null ? null :
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15,),
            child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                softWrap: true, textAlign: TextAlign.center, ),
          ),
        contentPadding: title == null ? EdgeInsets.zero : body == null ? EdgeInsets.zero :
          textCancel == null && textConfirm == null ? EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 8)
              : const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
        insetPadding:  EdgeInsets.zero ,
        titlePadding: title == null ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
        surfaceTintColor: Colors.white,
        actionsPadding: title == null ? EdgeInsets.zero : textCancel == null && textConfirm == null ? EdgeInsets.zero :
          EdgeInsets.only(bottom: textConfirm != null || textCancel != null ? 5 : 0, left: 5, right: 5),
        content: Padding(
          padding: EdgeInsets.only(top: body == null ? 0 : 15),
          child:  body ?? Container(),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(textCancel != null)
                CustomButtom.custom(
                  title: textCancel,
                  color: Colors.red,
                  icon: iconCancel,
                  onPressed: () async {
                    if(quit) Navigator.pop(context);
                    if(cancel != null) await cancel;
                  },
                ),
              if(textCancel != null && textConfirm != null)
                const SizedBox(width: 10,),
              if(textConfirm != null) CustomButtom.custom(
                title: textConfirm,
                icon: iconConfirm,
                onPressed: () async {
                  if(confirm != null) await confirm();
                  if(quit) Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }


  static bottomSheet(BuildContext context, {required Widget body}){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        barrierColor: Colors.black12.withOpacity(0.2),
        builder: (context){
          return  Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: body,
          );
        }
    );
  }
}

