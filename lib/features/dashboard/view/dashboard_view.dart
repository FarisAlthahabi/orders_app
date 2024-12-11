import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/features/dashboard/model/drawer_tile_enum.dart';
import 'package:orders_app/features/dashboard/model/navigation_bar_enum.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';

abstract class DashboardViewCallBacks {
  void onBottomTab(
    int currentIndex,
    TabsRouter tabsRouter,
  );
}

@RoutePage()
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    implements DashboardViewCallBacks {
  final tabTitles = [
    "home".tr(),
    "cart".tr(),
    "favorite".tr(),
    "profile".tr(),
  ];

  final icons = [
    Icons.home_outlined,
    Icons.shopping_basket_outlined,
    Icons.favorite_outlined,
    Icons.person_2_outlined
  ];

  @override
  void onBottomTab(int currentIndex, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                width: double.maxFinite,
                child: DrawerHeader(
                  padding: AppConstants.padding0,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Assets.images.logo.svg(),
                      Padding(
                        padding: AppConstants.paddingT120,
                        child: Text(
                          "kaba_delivery".tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.24,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Column(
                children: DrawerTileEnum.values.map(
                  (e) {
                    return Padding(
                      padding: AppConstants.padding2,
                      child: InkWell(
                        onTap: e.action(context),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          horizontalTitleGap: 20,
                          leading: Icon(
                            e.icon,
                            color: e.color,
                            size: 25,
                          ),
                          title: Text(
                            e.displayName,
                            style: TextStyle(
                              color: e.color,
                              fontSize: 20,
                              fontWeight: e == DrawerTileEnum.logout
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
      appBarBuilder: (context, tabsRouter) {
        return MainAppBar();
      },
      routes: [
        HomeRoute(),
        CartRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          backgroundColor: AppColors.whiteShade,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.black,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => onBottomTab(index, tabsRouter),
          showUnselectedLabels: true,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w600, height: 1.8),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w600, height: 1.8),
          showSelectedLabels: true,
          iconSize: 40,
          items: NavigationBarEnum.values
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon(),
                    color: tabsRouter.activeIndex == e.index
                        ? AppColors.mainColor
                        : AppColors.black,
                  ),
                  label: e.displayName(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
