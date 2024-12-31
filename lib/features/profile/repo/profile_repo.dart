import 'package:injectable/injectable.dart';
import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part 'profile_repo_imp.dart';

abstract class ProfileRepo {
  Future<CustomerModel> getProfile();
}
