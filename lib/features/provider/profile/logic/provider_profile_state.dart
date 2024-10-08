part of 'provider_profile_cubit.dart';

@immutable
abstract class ProviderProfileState {}

class ProviderProfileInitial extends ProviderProfileState {}
class EditingAddressState extends ProviderProfileState {}
class ChangePasswordVisibility extends ProviderProfileState {}
class ChangePasswordState extends ProviderProfileState {}
class GetProviderProfileState extends ProviderProfileState {
  final ProviderGetProfileModel providerGetProfileModel;
  GetProviderProfileState(this.providerGetProfileModel);
}

class GetMyWalletSuccessState extends ProviderProfileState {
}
class GetMyWalletLoadingState extends ProviderProfileState {}
class GetAddressListState extends ProviderProfileState {}
class AddAddressState extends ProviderProfileState {}
class EditAddressState extends ProviderProfileState {}
class DeleteAddressState extends ProviderProfileState {}
class UploadImage extends ProviderProfileState {}
class FCMTokenState extends ProviderProfileState {}
class UploadPDF extends ProviderProfileState {}
class ChangeRadio extends ProviderProfileState {}
class DeleteAccountState extends ProviderProfileState {}
class UpdateUserProfile extends ProviderProfileState {}
class AboutCompanyState extends ProviderProfileState {}
class ChangeLanguageState extends ProviderProfileState {}
class TestState extends ProviderProfileState {}
