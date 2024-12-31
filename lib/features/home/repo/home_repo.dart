import 'package:injectable/injectable.dart';
import 'package:orders_app/features/home/model/store_model/store_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part "home_repo_imp.dart";

abstract class HomeRepo {
  Future<List<StoreModel>> getStores();

  Future<List<StoreModel>> getSearchedStores(String input);
}
