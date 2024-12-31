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
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class HomeViewCallBacks {
  void onSearchChanged(String value);

  void onSearchSubmitted(String value);

  void onStoreTap(String storeName, int storeId);

  Future<void> onRefresh();

  void onTryAgainTap();
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
  Future<void> onRefresh() async {
    homeCubit.getStores();
  }

  @override
  void onTryAgainTap() {
    homeCubit.getStores();
  }

  @override
  void onSearchChanged(String searchInput) {
    if (searchInput.isEmpty) {
      homeCubit.getStores();
    }
  }

  @override
  void onSearchSubmitted(String value) {
    homeCubit.getSearchedStores(value);
  }

  @override
  void onStoreTap(String storeName, int storeId) {
    context.router.push(
      ProductsRoute(
        storeName: storeName,
        storeId: storeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.padding16,
        child: RefreshIndicator(
          onRefresh: onRefresh,
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
                      return LoadingIndicator(
                        color: AppColors.black,
                      );
                    } else if (state is HomeSuccess) {
                      return GridView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: state.stores.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final store = state.stores[index];
                          return StoreTile(
                            store: store,
                            onPressed: onStoreTap,
                          );
                        },
                      );
                    } else if (state is HomeEmpty) {
                      return MainErrorWidget(message: state.message);
                    } else if (state is HomeFail) {
                      return MainErrorWidget(
                        message: state.error,
                        onTap: onTryAgainTap,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
