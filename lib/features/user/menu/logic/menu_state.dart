part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class GetPackageCheckState extends MenuState {
  final PackageCheckModel packageCheckModel;
  GetPackageCheckState(this.packageCheckModel);
}
class GetBannersState extends MenuState {
  final BannersModel bannersModel;
  GetBannersState(this.bannersModel);
}
class RemoveState extends MenuState {}
