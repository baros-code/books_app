// import 'dart:math';

// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';

// import '../../common/models/routing/route_definition.dart';
// import '../../common/models/routing/route_setup_params.dart';
// import '../logging/logger.dart';

// abstract class RouteManager {
//   /// This should be given to MaterialApp.onGenerateRoute.
//   Route<dynamic>? Function(RouteSettings)? get generator;

//   GlobalKey<NavigatorState> get navigatorKey;

//   void setup(RouteSetupParams setupParams);

//   /// Gets the current route.
//   String? getCurrentRoute(BuildContext context);

//   /// Navigates to the given [route] with optional [params].
//   Future<void> goRoute(
//     BuildContext context,
//     String route, {
//     Object? params,
//   });

//   /// Navigates to the given [route]
//   /// removing all the others with optional [params].
//   Future<void> goRouteAsRoot(
//     BuildContext context,
//     String route, {
//     Object? params,
//   });

//   /// Navigates back to the previous route.
//   void goBack(BuildContext context);

//   /// Navigates back to a [route] removing all the routes in between.
//   void returnRoute(
//     BuildContext context,
//     String route,
//   );

//   /// Replaces the current route with the given [route].
//   Future<void> replaceRoute(
//     BuildContext context,
//     String route, {
//     Object? params,
//   });

//   /// Refreshes the current route.
//   Future<void> refreshRoute(
//     BuildContext context, {
//     Object? params,
//   });
// }

// /// RouteManager Implementation
// class RouteManagerImpl implements RouteManager {
//   RouteManagerImpl(this._logger);

//   final Logger _logger;

//   final _router = FluroRouter();
//   final _navigatorKey = GlobalKey<NavigatorState>();
//   final _transitionTimer = Stopwatch();

//   bool _canNavigateForward = true;

//   @override
//   Route<dynamic>? Function(RouteSettings)? get generator => _router.generator;

//   @override
//   GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

//   @override
//   void setup(RouteSetupParams setupParams) {
//     for (final definition in setupParams.routeDefinitions) {
//       _router.define(
//         definition.routePath,
//         handler: Handler(
//           handlerFunc: (context, _) {
//             return _buildRouteWidget(context, definition);
//           },
//         ),
//         transitionType: definition.transitionType != null
//             ? TransitionType.values.byName(
//                 definition.transitionType!.name,
//               )
//             : null,
//         transitionBuilder: definition.transitionBuilder,
//         transitionDuration: definition.transitionDuration,
//       );
//     }
//   }

//   @override
//   String? getCurrentRoute(BuildContext context) {
//     String? currentRoute;
//     Navigator.of(context).popUntil((route) {
//       currentRoute = route.settings.name;
//       return true;
//     });
//     return currentRoute;
//   }

//   @override
//   Future<void> goRoute(
//     BuildContext context,
//     String route, {
//     Object? params,
//   }) async {
//     try {
//       if (!_canNavigateForward) return;
//       _restartTransitionTimer();
//       await Navigator.of(context).pushNamed(
//         route,
//         arguments: params,
//       );
//     } catch (e) {
//       _logger.error(
//         'Navigating to $route failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//   }

//   @override
//   Future<void> goRouteAsRoot(
//     BuildContext context,
//     String route, {
//     Object? params,
//   }) async {
//     try {
//       if (!_canNavigateForward) return;
//       _restartTransitionTimer();
//       await Navigator.of(context).pushNamedAndRemoveUntil(
//         route,
//         arguments: params,
//         (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       _logger.error(
//         'Navigating to $route as root failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//   }

//   @override
//   void goBack(BuildContext context) {
//     try {
//       if (Navigator.of(context).canPop()) {
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       _logger.error(
//         'Navigating back failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//   }

//   @override
//   void returnRoute(
//     BuildContext context,
//     String route,
//   ) {
//     try {
//       Navigator.of(context).popUntil(
//         ModalRoute.withName(route),
//       );
//     } catch (e) {
//       _logger.error(
//         'Returning to $route failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//   }

//   @override
//   Future<void> replaceRoute(
//     BuildContext context,
//     String route, {
//     Object? params,
//   }) {
//     try {
//       return Navigator.of(context).pushReplacementNamed(
//         route,
//         arguments: params,
//       );
//     } catch (e) {
//       _logger.error(
//         'Replacing route with $route failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//     return Future.value();
//   }

//   @override
//   Future<void> refreshRoute(
//     BuildContext context, {
//     Object? params,
//   }) {
//     try {
//       // Get the current route name.
//       final currentRoute = getCurrentRoute(context);
//       if (currentRoute == null) {
//         _logger.error(
//           'Refreshing current route failed '
//           'as route name could not be determined.',
//           callerType: runtimeType,
//         );
//         return Future.value();
//       }
//       // Refresh the current route.
//       return Navigator.of(context).pushReplacementNamed(
//         currentRoute,
//         arguments: params,
//       );
//     } catch (e) {
//       _logger.error(
//         'Refreshing current route failed.\n${e.toString()}',
//         callerType: runtimeType,
//       );
//     }
//     return Future.value();
//   }

//   // Helpers
//   Widget _buildRouteWidget(BuildContext? context, RouteDefinition definition) {
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (didPop) {
//         if (didPop) {
//           _blockNavigateForwardUntilTransitionCompletes(
//             definition.transitionDuration,
//           );
//         }
//       },
//       // Construct the page as per the definition.
//       child: definition.routeHandler(
//         context,
//         ModalRoute.of(context!)?.settings.arguments,
//       ),
//     );
//   }

//   void _blockNavigateForwardUntilTransitionCompletes(
//     Duration transitionDuration,
//   ) {
//     _canNavigateForward = false;
//     _transitionTimer.stop();

//     const delayOffsetMs = 50;
//     final delayInMilliseconds = min(
//       transitionDuration.inMilliseconds + delayOffsetMs,
//       _transitionTimer.elapsedMilliseconds + delayOffsetMs,
//     );
//     Future.delayed(
//       Duration(milliseconds: delayInMilliseconds),
//       () => _canNavigateForward = true,
//     );
//   }

//   void _restartTransitionTimer() {
//     _transitionTimer.reset();
//     _transitionTimer.start();
//   }
//   // - Helpers
// }
