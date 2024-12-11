import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/home/cubit/home_cubit.dart';
import 'package:orders_app/features/home/view/widgets/store_tile.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class HomeViewCallBacks {
  void onSearchChanged(String value);

  void onSearchSubmitted(String value);

  void onStoreTap(String storeName);
}

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<HomeCubit>(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeViewCallBacks {
  late final HomeCubit homeCubit = context.read();

  final searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    homeCubit.getStores();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void onSearchChanged(String value) {
    // TODO: implement onSearchChanged
  }

  @override
  void onSearchSubmitted(String value) {
    // TODO: implement onSearchSubmitted
  }

  @override
  void onStoreTap(String storeName) {
    context.router.push(ProductsRoute(storeName: storeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "available_stores".tr(),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                height: 1.22,
              ),
            ),
            SizedBox(height: 20),
            MainTextField(
              prefixIcon: Icon(Icons.search_outlined),
              hintText: "search".tr(),
              onChanged: onSearchChanged,
              onSubmitted: onSearchSubmitted,
              focusNode: searchFocusNode,
            ),
            SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<HomeCubit, GeneralHomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeSuccess) {
                    return GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: state.stores.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final item = state.stores[index];
                        return StoreTile(
                          image: item.image,
                          name: item.name,
                          location: item.location,
                          onPressed: onStoreTap,
                        );
                      },
                    );
                  } else if (state is HomeEmpty) {
                    return Center(child: Text(state.message));
                  } else if (state is HomeFail) {
                    return Center(child: Text(state.error));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
