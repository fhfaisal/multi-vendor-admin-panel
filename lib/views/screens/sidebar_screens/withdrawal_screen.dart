import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/refactor_widgets/refactor_widgets.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName='/Withdrawal';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Withdrawal',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(context: context, text: 'name', flex: 3),
              RowHeaderWidget(context: context, text: 'amount', flex: 3),
              RowHeaderWidget(context: context, text: 'bank name', flex: 4),
              RowHeaderWidget(context: context, text: 'bank account', flex: 4),
              RowHeaderWidget(context: context, text: 'email', flex: 3),
              RowHeaderWidget(context: context, text: 'phone', flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
