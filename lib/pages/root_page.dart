import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_craft/pages/favourites_page.dart';
import 'package:menu_craft/pages/home_page.dart';
import 'package:menu_craft/pages/profile/profile_page.dart';
import 'package:menu_craft/pages/scan_qr_page.dart';
import 'package:menu_craft/pages/search_page.dart';
import 'package:menu_craft/services/auth_service.dart';
import 'package:menu_craft/utils/location_services.dart';
import 'package:menu_craft/utils/toastification.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../models/providers/user_provider.dart';
import '../services/db_service.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final AuthService authProvider = AuthService();

  final DbAuthService _db = DbAuthService();

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const SearchPage(),
      const QrScanner(),
      const ProfilePage(),
      const FavoritesPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.qrcode),
        title: ("Scan QR Code"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.star),
        title: ("Favorites"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    context.read<LocationService>().determinePosition().catchError((onError){
      InterfaceUtils.show(context, onError.toString(), type:ToastificationType.error);
    });
    if (AuthService.isUserLoggedIn()) {
      if (context.read<UserProvider>().user == null) {
        _db.getUser(AuthService.user!.uid).then((user) {
          context.read<UserProvider>().setUser(user);
        });
      }
    }
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color.fromRGBO(29, 27, 32, 1),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
