import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/category_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/dashboard_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/order_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/products_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/upload_banner_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/vendors_screen.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/withdrawal_screen.dart';
import 'package:multi_vendor_admin/widget_setting/color_collections.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Track the currently selected screen
  late Widget _selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize the selected screen to DashboardScreen
    _selectedItem = DashboardScreen();
  }

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;
      case VendorScreen.routeName:
        setState(() {
          _selectedItem = VendorScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });
        break;
      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;
      case CategoryScreen.routeName:
        setState(() {
          _selectedItem = CategoryScreen();
        });
        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: scaffoldBgClr,
        appBar: AppBar(
          backgroundColor: appbarColor,
          centerTitle: true,
          title: Text(
            'Admin Panel'.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: SideBar(
          iconColor: iconClr,
          activeBackgroundColor: appbarColor,
          items: [
            AdminMenuItem(
                title: 'Dashboard',
                icon: Icons.dashboard,
                route: DashboardScreen.routeName),
            AdminMenuItem(
                title: 'Vendors',
                icon: CupertinoIcons.person_3_fill,
                route: VendorScreen.routeName),
            AdminMenuItem(
                title: 'Withdrawal',
                icon: CupertinoIcons.money_dollar,
                route: WithdrawalScreen.routeName),
            AdminMenuItem(
                title: 'Orders',
                icon: CupertinoIcons.shopping_cart,
                route: OrderScreen.routeName),
            AdminMenuItem(
                title: 'Categories',
                icon: Icons.category,
                route: CategoryScreen.routeName),
            AdminMenuItem(
                title: 'Upload Banner',
                icon: Icons.add,
                route: UploadBannerScreen.routeName),
            AdminMenuItem(
                title: 'Products',
                icon: Icons.shop,
                route: ProductScreen.routeName),
          ],
          selectedRoute: '/',
          onSelected: (item) {
            screenSelector(item);
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Management',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                '© 2023 Faisal Hasan. All rights reserved. ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: _selectedItem);
  }
}
