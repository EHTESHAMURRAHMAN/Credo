import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget heading(String heading1, String heading2, {Color? color}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        heading1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: color,
        ),
      ),
      const SizedBox(width: 8),
      Text(
        heading2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: color,
        ),
      ),
    ],
  );
}

Widget backButton({Color? color}) {
  return InkWell(
    onTap: () => Get.back(),
    child: Icon(Icons.arrow_back_ios, color: color),
  );
}
