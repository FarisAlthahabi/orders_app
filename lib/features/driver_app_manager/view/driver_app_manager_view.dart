import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DriverAppManagerView extends StatelessWidget {
  const DriverAppManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DriverAppManagerPage();
  }
}

class DriverAppManagerPage extends StatefulWidget {
  const DriverAppManagerPage({super.key});

  @override
  State<DriverAppManagerPage> createState() => _DriverAppManagerPageState();
}

class _DriverAppManagerPageState extends State<DriverAppManagerPage> {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
