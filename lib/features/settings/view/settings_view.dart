import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';

abstract class SettingsViewCallBacks{}

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

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
    );
  }
}