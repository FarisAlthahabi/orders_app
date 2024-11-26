import 'package:auto_route/auto_route.dart';
import 'package:orders_app/global/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Tab|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
          // children: [
          //   AutoRoute(
          //     page: SignUpRoute.page,
          //   ),
          // ],
        ),
        AutoRoute(
              page: IntroRoute.page,
            ),
             AutoRoute(
              page: SignUpRoute.page,
            ),
      ];
}
