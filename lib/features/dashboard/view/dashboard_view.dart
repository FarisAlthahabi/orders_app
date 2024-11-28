import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/features/dashboard/model/navigation_bar_enum.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
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
      drawer: Drawer(
        
        child: DrawerHeader(
          child: Container(
            color: Colors.red,
          )),
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
          backgroundColor: Color(0XFFF5F6F7),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.black,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => onBottomTab(index, tabsRouter),
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600 ,
            height: 1.8
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600 ,
            height: 1.8
          ),
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
