import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

@RoutePage()
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<FavoriteCubit>(),
      child: const FavoritePage(),
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late final FavoriteCubit favoriteCubit = context.read();
  @override
  void initState() {
    favoriteCubit.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppManagerCubit, AppManagerState>(
      listener: (context, state) {
        if (state is FavoriteAdded) {
          favoriteCubit.addFavorite(state.product);
        } else if (state is FavoriteRemoved) {
          favoriteCubit.removeFavorite(state.product);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: AppConstants.padding16,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Expanded(
                    child: BlocBuilder<FavoriteCubit, GeneralFavoriteState>(
                      buildWhen: (previous, current) =>
                          current is FavoriteState,
                      builder: (context, state) {
                        if (state is FavoriteSuccess) {
                          return ListView.separated(
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductTile(
                                index: index,
                                product: product,
                                isCollecting: false,
                                onPressed: () {},
                                onFavorite: (index, isFavorite) {
                                  favoriteCubit.removeFavorite(product);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                          );
                        } else if (state is FavoriteEmpty) {
                          return Center(child: Text(state.message));
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
