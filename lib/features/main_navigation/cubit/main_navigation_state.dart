part of 'main_navigation_cubit.dart';

@immutable
sealed class MainNavigationState {}

final class MainNavigationInitial extends MainNavigationState {}

final class AppManagerRouteState extends MainNavigationState {}

final class DriverAppManagerRouteState extends MainNavigationState {}
