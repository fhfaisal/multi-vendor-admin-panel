
import 'package:flutter/material.dart';

import '../../../../widget_setting/color_collections.dart';

class RowHeaderWidget extends StatelessWidget {
  const RowHeaderWidget({
    super.key,
    required this.context,
    required this.text,
    required this.flex,
  });

  final BuildContext context;
  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0; // Default font size
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      fontSize = 10.0; // Adjust font size for smaller screens
    }

    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColors,
          border: Border.all(
            color: blackClr,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text.toUpperCase(),
            maxLines: 1,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: whiteClr), // Apply adjusted font size
          ),
        ),
      ),
    );
  }
}