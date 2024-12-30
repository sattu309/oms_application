import 'package:flutter/material.dart';
import 'package:oms_app/resuources/constants.dart';

class CommonButtonBlue extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CommonButtonBlue({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppTextColor.primaryColor
        ),
        child:
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              // minimumSize: 79,
              backgroundColor: AppTextColor.primaryColor,
              // backgroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // <-- Radius
              ),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 15)),

              ],
            )),
      );
  }
}
