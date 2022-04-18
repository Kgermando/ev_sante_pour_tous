import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/constants/responsive.dart';
  dialogWidget(BuildContext context, Widget child) {
    StateSetter _setState;
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            _setState = setState;
              return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(p8),
              ),
              backgroundColor: Colors.transparent,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(p16),
                  child: SizedBox(
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width,
                      child: child),
                ),
              )
            );
          }
        );
      }
    );
  }
