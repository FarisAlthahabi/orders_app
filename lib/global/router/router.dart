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
        ),
        AutoRoute(
          page: IntroRouter.page,
          children: [
            AutoRoute(page: IntroRoute.page),
            AutoRoute(page: SelectRoleRoute.page),
          ],
        ),
        AutoRoute(page: SignUpRoute.page),
        AdaptiveRoute(
          page: AppManagerRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: DashboardRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: HomeRoute.page,
                ),
                AutoRoute(page: CartRoute.page),
                AutoRoute(page: FavoriteRoute.page),
                AutoRoute(page: ProfileRoute.page)
              ],
            ),
            AutoRoute(page: ProductsRoute.page),
            AutoRoute(page: SettingsRoute.page)
          ],
        ),
      ];
}
