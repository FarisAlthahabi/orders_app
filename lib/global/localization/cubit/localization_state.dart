part of 'localization_cubit.dart';

@immutable
 class LocalizationState {
  final Locale locale;

  const LocalizationState(this.locale);
}

final class LocalizationInitial extends LocalizationState {
  const LocalizationInitial(super.locale);
}
