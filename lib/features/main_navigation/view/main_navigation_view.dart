import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/cart/cubit/orders_cubit.dart';
import 'package:orders_app/features/main_navigation/cubit/main_navigation_cubit.dart';
import 'package:orders_app/features/product_details/cubit/product_details_cubit.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/widgets/restart_app_widget.dart';

@RoutePage()
class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainNavigationCubit>(
          create: (context) => get<MainNavigationCubit>(),
        ),
        BlocProvider(
          create: (context) => get<OrdersCubit>(),
        ),
                BlocProvider(
          create: (context) => get<ProductDetailsCubit>(),
        ),
      ],
      child: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late final MainNavigationCubit mainNavigationCubit = context.read();

  @override
  void initState() {
    super.initState();
    mainNavigationCubit.detectRoute();
  }

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: BlocBuilder<MainNavigationCubit, MainNavigationState>(
        builder: (context, state) {
          return AutoRouter.declarative(
            routes: (context) {
              return [
                if (state is AppManagerRouteState) const AppManagerRoute(),
                if (state is DriverAppManagerRouteState)
                  const DriverAppManagerRoute(),
              ];
            },
          );
        },
      ),
    );
  }
}
