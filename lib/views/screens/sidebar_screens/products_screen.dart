import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/refactor_widgets/refactor_widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName='/Products';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(context: context, text: 'Image', flex: 3),
              RowHeaderWidget(context: context, text: 'name', flex: 7),
              RowHeaderWidget(context: context, text: 'price', flex: 3),
              RowHeaderWidget(context: context, text: 'quantity', flex: 3),
              RowHeaderWidget(context: context, text: 'action', flex: 3),
              RowHeaderWidget(context: context, text: 'view more', flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
