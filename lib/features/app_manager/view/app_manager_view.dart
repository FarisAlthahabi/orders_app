import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/global/di/di.dart';

@RoutePage()
class AppManagerView extends StatelessWidget {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<AppManagerCubit>(),
        ),
        BlocProvider(
          create: (context) => get<FavoriteCubit>(),
        ),
      ],
      child: const AppManagerPage(),
    );
  }
}

class AppManagerPage extends StatefulWidget {
  const AppManagerPage({super.key});

  @override
  State<AppManagerPage> createState() => _AppManagerPageState();
}

class _AppManagerPageState extends State<AppManagerPage> {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
