import 'package:flutter/material.dart';
import 'package:flutter_avance/UI/navigation/navigation_path.dart';

class NavigationRouterParser extends RouteInformationParser<NavigationPath> {
  @override
  Future<NavigationPath> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '/');

    final int? userId;
    if (uri.pathSegments.length >= 2) {
      userId = int.tryParse(uri.pathSegments[1]);
    } else {
      userId = null;
    }
    return Future.value(NavigationPath(userId: userId));
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationPath configuration) {
    String location = "/";
    final userId = configuration.userId;
    if (userId != null) {
      location = location + "user/$userId";
    }
    return RouteInformation(location: location);
  }
}
