import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

@injectable
class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial(Locale('en')));

  void setLocale(Locale locale) {
    emit(LocalizationState(locale));
  }
}
