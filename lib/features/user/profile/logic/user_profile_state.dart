part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class GetUserProfileState extends UserProfileState {
  final UserProfileModel userProfileModel;
  GetUserProfileState(this.userProfileModel);
}

class LoadingState extends UserProfileState {}
class UploadImage extends UserProfileState {}
class DeleteAccountState extends UserProfileState {}
class UpdateUserProfile extends UserProfileState {}
class AboutCompanyUserState extends UserProfileState {}
