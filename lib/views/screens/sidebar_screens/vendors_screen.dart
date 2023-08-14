import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/refactor_widgets/refactor_widgets.dart';
class VendorScreen extends StatelessWidget {
  static const String routeName = '/Vendors';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Vendors',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(context: context, text: 'logo', flex: 3),
              RowHeaderWidget(context: context, text: 'business name', flex: 5),
              RowHeaderWidget(context: context, text: 'city', flex: 4),
              RowHeaderWidget(context: context, text: 'state', flex: 4),
              RowHeaderWidget(context: context, text: 'action', flex: 3),
              RowHeaderWidget(context: context, text: 'view more', flex: 3),
            ],
          )
        ],
      ),
    );
  }
}

