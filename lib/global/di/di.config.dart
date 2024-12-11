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
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart'
    as _i303;
import 'package:orders_app/features/home/cubit/home_cubit.dart' as _i615;
import 'package:orders_app/features/sign_up/cubit/sign_up_cubit.dart' as _i80;
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart' as _i128;
import 'package:orders_app/global/di/modules/app_module.dart' as _i212;
import 'package:orders_app/global/dio/dio_client.dart' as _i945;
import 'package:orders_app/global/repos/user_repo.dart' as _i614;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i198.AppManagerCubit>(() => _i198.AppManagerCubit());
    gh.factory<_i303.FavoriteCubit>(() => _i303.FavoriteCubit());
    gh.factory<_i615.HomeCubit>(() => _i615.HomeCubit());
    gh.singletonAsync<bool>(() => appModule.disablePrintOnRelease());
    gh.singleton<_i945.DioClient>(() => _i945.DioClient());
    gh.singleton<_i614.UserRepo>(() => _i614.UserRepo());
    gh.factory<_i128.SignUpRepo>(() => _i128.SignUpRepoImp());
    gh.factory<_i80.SignUpCubit>(
        () => _i80.SignUpCubit(gh<_i128.SignUpRepo>()));
    return this;
  }
}

class _$AppModule extends _i212.AppModule {}
