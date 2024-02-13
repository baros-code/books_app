// import 'package:books_app/configs/router/route_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({
//     super.key,
//     required this.child,
//     required this.location,
//   });

//   final Widget child;
//   final String location;

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;

//   static const List<MyCustomBottomNavBarItem> tabs = [
//     MyCustomBottomNavBarItem(
//       icon: Icon(Icons.home),
//       activeIcon: Icon(Icons.home),
//       label: 'HOME',
//       initialLocation: RouteConfig.mainRoute,
//     ),
//     MyCustomBottomNavBarItem(
//       icon: Icon(Icons.explore_outlined),
//       activeIcon: Icon(Icons.explore),
//       label: 'DISCOVER',
//       initialLocation: '/discover',
//     ),
//     MyCustomBottomNavBarItem(
//       icon: Icon(Icons.storefront_outlined),
//       activeIcon: Icon(Icons.storefront),
//       label: 'SHOP',
//       initialLocation: '/shop',
//     ),
//     MyCustomBottomNavBarItem(
//       icon: Icon(Icons.account_circle_outlined),
//       activeIcon: Icon(Icons.account_circle),
//       label: 'MY',
//       initialLocation: '/login',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     const labelStyle = TextStyle(fontFamily: 'Roboto');
//     return Scaffold(
//       body: SafeArea(child: widget.child),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedLabelStyle: labelStyle,
//         unselectedLabelStyle: labelStyle,
//         selectedItemColor: const Color(0xFF434343),
//         selectedFontSize: 12,
//         unselectedItemColor: const Color(0xFF838383),
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         onTap: (int index) {
//           _goOtherTab(context, index);
//         },
//         currentIndex: widget.location == '/'
//             ? 0
//             : widget.location == '/discover'
//                 ? 1
//                 : widget.location == '/shop'
//                     ? 2
//                     : 3,
//         items: tabs,
//       ),
//     );
//   }

//   void _goOtherTab(BuildContext context, int index) {
//     if (index == _currentIndex) return;
//     GoRouter router = GoRouter.of(context);
//     String location = tabs[index].initialLocation;
//     setState(() {
//       _currentIndex = index;
//     });
//     // if (index == 3) {
//     //   context.push('/login');
//     // }
//     //  else {
//     router.go(location);
//     // }
//   }
// }

// class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
//   final String initialLocation;

//   const MyCustomBottomNavBarItem(
//       {required this.initialLocation,
//       required super.icon,
//       super.label,
//       Widget? activeIcon})
//       : super(activeIcon: activeIcon ?? icon);
// }
