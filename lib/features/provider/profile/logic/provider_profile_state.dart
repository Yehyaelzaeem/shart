part of 'provider_profile_cubit.dart';

@immutable
abstract class ProviderProfileState {}

class ProviderProfileInitial extends ProviderProfileState {}
class UserProfileInitial extends ProviderProfileState {}
class EditingAddressState extends ProviderProfileState {}
class GetUserProfileState extends ProviderProfileState {}
class GetAddressListState extends ProviderProfileState {}
class AddAddressState extends ProviderProfileState {}
class EditAddressState extends ProviderProfileState {}
class DeleteAddressState extends ProviderProfileState {}
class UploadImage extends ProviderProfileState {}
class ChangeRadio extends ProviderProfileState {}
class DeleteAccountState extends ProviderProfileState {}
class UpdateUserProfile extends ProviderProfileState {}
class AboutCompanyState extends ProviderProfileState {}
class ChangeLanguageState extends ProviderProfileState {}
