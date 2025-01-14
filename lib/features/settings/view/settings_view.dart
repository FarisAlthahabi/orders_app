import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';
import 'package:orders_app/global/widgets/restart_app_widget.dart';

abstract class SettingsViewCallBacks {
  void changeLanguage(bool value);
}

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPage();
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    implements SettingsViewCallBacks {
  late bool isEnglish = context.locale == Locale('en');
  
  @override
  void changeLanguage(bool value) {
    setState(() {
      if (context.locale == Locale('en')) {
        context.setLocale(Locale('ar'));
      } else {
        context.setLocale(Locale('en'));
      }
      isEnglish = value;
    });
    RestartAppWidget.restartApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            SwitchListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "language".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.22,
                    ),
                  ),
                  Text(
                    context.locale == Locale('en')
                        ? "english".tr()
                        : "arabic".tr(),
                    style: TextStyle(
                      color: AppColors.blackShade,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.22,
                    ),
                  ),
                ],
              ),
              value: isEnglish,
              onChanged: changeLanguage
            )
          ],
        ),
      ),
    );
  }
}
