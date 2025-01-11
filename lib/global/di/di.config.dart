// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart'
    as _i198;
import 'package:orders_app/features/cart/cubit/orders_cubit.dart' as _i289;
import 'package:orders_app/features/cart/repo/order_repo.dart' as _i706;
import 'package:orders_app/features/dashboard/cubit/dashboard_cubit.dart'
    as _i318;
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart'
    as _i303;
import 'package:orders_app/features/favorite/repo/favorite_repo.dart' as _i0;
import 'package:orders_app/features/home/cubit/home_cubit.dart' as _i615;
import 'package:orders_app/features/home/repo/home_repo.dart' as _i680;
import 'package:orders_app/features/order_details/cubit/order_details_cubit.dart'
    as _i769;
import 'package:orders_app/features/order_details/repo/order_details_repo.dart'
    as _i1053;
import 'package:orders_app/features/product_details/cubit/product_details_cubit.dart'
    as _i551;
import 'package:orders_app/features/product_details/repo/product_details_repo.dart'
    as _i654;
import 'package:orders_app/features/products/cubit/products_cubit.dart'
    as _i590;
import 'package:orders_app/features/products/repo/products_repo.dart' as _i707;
import 'package:orders_app/features/profile/cubit/profile_cubit.dart' as _i19;
import 'package:orders_app/features/profile/repo/profile_repo.dart' as _i288;
import 'package:orders_app/features/sign_up/cubit/sign_up_cubit.dart' as _i80;
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart' as _i128;
import 'package:orders_app/global/di/modules/app_module.dart' as _i212;
import 'package:orders_app/global/dio/dio_client.dart' as _i945;
import 'package:orders_app/global/localization/cubit/localization_cubit.dart'
    as _i646;
import 'package:orders_app/global/repos/user_repo.dart' as _i614;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i198.AppManagerCubit>(() => _i198.AppManagerCubit());
    gh.factory<_i646.LocalizationCubit>(() => _i646.LocalizationCubit());
    gh.singletonAsync<bool>(() => appModule.disablePrintOnRelease());
    gh.singleton<_i945.DioClient>(() => _i945.DioClient());
    await gh.singletonAsync<_i614.UserRepo>(
      () {
        final i = _i614.UserRepo();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i288.ProfileRepo>(() => _i288.ProfileRepoImp());
    gh.factory<_i128.SignUpRepo>(() => _i128.SignUpRepoImp());
    gh.factory<_i1053.OrderDetailsRepo>(() => _i1053.OrderDetailsRepoImp());
    gh.factory<_i0.FavoriteRepo>(() => _i0.FavoriteRepoImp());
    gh.factory<_i654.ProductDetailsRepo>(() => _i654.ProductDetailsRepoImp());
    gh.factory<_i680.HomeRepo>(() => _i680.HomeRepoImp());
    gh.factory<_i707.ProductsRepo>(() => _i707.ProductsRepoImp());
    gh.factory<_i706.OrderRepo>(() => _i706.OrderRepoImp());
    gh.factory<_i289.OrdersCubit>(
        () => _i289.OrdersCubit(gh<_i706.OrderRepo>()));
    gh.factory<_i318.DashboardCubit>(
        () => _i318.DashboardCubit(gh<_i128.SignUpRepo>()));
    gh.factory<_i80.SignUpCubit>(
        () => _i80.SignUpCubit(gh<_i128.SignUpRepo>()));
    gh.factory<_i19.ProfileCubit>(
        () => _i19.ProfileCubit(gh<_i288.ProfileRepo>()));
    gh.factory<_i303.FavoriteCubit>(
        () => _i303.FavoriteCubit(gh<_i0.FavoriteRepo>()));
    gh.factory<_i769.OrderDetailsCubit>(
        () => _i769.OrderDetailsCubit(gh<_i1053.OrderDetailsRepo>()));
    gh.factory<_i590.ProductsCubit>(
        () => _i590.ProductsCubit(gh<_i707.ProductsRepo>()));
    gh.factory<_i615.HomeCubit>(() => _i615.HomeCubit(gh<_i680.HomeRepo>()));
    gh.factory<_i551.ProductDetailsCubit>(
        () => _i551.ProductDetailsCubit(gh<_i654.ProductDetailsRepo>()));
    return this;
  }
}

class _$AppModule extends _i212.AppModule {}
