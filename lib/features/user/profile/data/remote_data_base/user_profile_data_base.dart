import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/core/routing/routes.dart';
import '../../../../../core/network/apis.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/shared_preference/shared_preference.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../../provider/profile/data/model/about_compay_model.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/user_profile_cubit.dart';
import '../model/compaints_message_model.dart';
import '../model/delete_account_model.dart';
import '../model/message_model.dart';
import '../model/user_profile_model.dart';

abstract class BaseUserProfileRemoteDataSource{
  Future<UserProfileModel?> getUserProfile(String token ,BuildContext context);
  Future<UserProfileModel?> updateProfile(UserProfileModel userProfileModel ,String token ,BuildContext context);
  Future<DeleteAccountModel?> deleteAccount(String token ,BuildContext context);

  Future<AboutCompanyModel?> getABoutCompanyUser(BuildContext context);
  Future<AboutCompanyModel?> getTermsAndConditionsUser(BuildContext context);
  Future<AboutCompanyModel?> getPrivacyUser(BuildContext context);
  Future<ComplaintMessageModel?> sendComplaintMessage(MessageModel messageModel ,BuildContext context);

}

class UserProfileRemoteDataSource implements BaseUserProfileRemoteDataSource {


  @override
  Future<UserProfileModel?> getUserProfile(String token, BuildContext context) async{
    dynamic t = await CacheHelper.getDate(key: 'token');
    Response<dynamic> res = await DioHelper.getData(url: AppApis.getProfileUser, token: token.isNotEmpty?token:t);

    if (UserProfileModel.fromJson(res.data).success == false) {
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return UserProfileModel.fromJson(res.data);
      }
      else {
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }



  @override
  Future<UserProfileModel?> updateProfile(UserProfileModel userProfileModel ,String token, BuildContext context) async{
    UserProfileCubit cubit =UserProfileCubit.get(context);
    FormData data = FormData.fromMap({
      'image':
      cubit.profileImageFile!=null?
      <MultipartFile>[
        await MultipartFile.fromFile('${cubit.profileImageFile!.path}', filename: 'upload')
      ]:null,
      'name':userProfileModel.data!.name,
      'email':userProfileModel.data!.email,
      'phone':userProfileModel.data!.phone,
      'phone_country_id':'3',
      'country_id':'1',
      'city_id':'1',
      'gender':'male',
      'birth_date':'1990-01-01',
    });
    cubit.changeUpdateLoading(true);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.updateProfileUser,
        token: token,
       dataOption: data,
    );

    if (UserProfileModel.fromJson(res.data).success == false) {
      cubit.changeUpdateLoading(false);
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {

        cubit.getUserProfile('${AuthCubit.get(context).token}', context);
        cubit.changeUpdateLoading(false);
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.success, context: context);

        return UserProfileModel.fromJson(res.data);
      }
      else {

        cubit.changeUpdateLoading(false);
        showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<DeleteAccountModel?> deleteAccount(String token, BuildContext context) async{
    Response<dynamic> res = await DioHelper.postData(url: AppApis.deleteAccount,
      token: token,);

    if (DeleteAccountModel.fromJson(res.data).success == false) {
      showToast(text: '${UserProfileModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        showToast(text: '${DeleteAccountModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
         NavigationManager.pushReplacement(Routes.login);
        return DeleteAccountModel.fromJson(res.data);
      }
      else {
        showToast(text: '${DeleteAccountModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
        throw 'Error';
      }
    }
    return null;
  }


  @override
  Future<AboutCompanyModel?> getABoutCompanyUser(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(
        language:  cubit.localeLanguage==Locale('en')?'en':'ar',
        url: AppApis.aboutCompany);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AboutCompanyModel?> getPrivacyUser(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.privacyAndPolicyUser, language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<AboutCompanyModel?> getTermsAndConditionsUser(BuildContext context) async{
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.getData(url: AppApis.termsAndConditionUser,
      language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (AboutCompanyModel.fromJson(res.data).success == false) {
      // showToast(text: '${AddressListModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {
        print('${AboutCompanyModel.fromJson(res.data).data!.content}');
        return AboutCompanyModel.fromJson(res.data);
      }
      else {
        throw 'Error';
      }
    }
    return null;
  }

  @override
  Future<ComplaintMessageModel?> sendComplaintMessage(MessageModel messageModel, BuildContext context) async{
    UserProfileCubit.get(context).changeUpdateLoading(true);
    AuthCubit cubit =AuthCubit.get(context);
    Response<dynamic> res = await DioHelper.postData(url: AppApis.complaintMessage,
      data: <String,dynamic>{
         'name':messageModel.name,
         'phone':messageModel.phone,
         'email':messageModel.email,
         'message':messageModel.message,
         'type':messageModel.type,
         'message_type':messageModel.message_type,
      },
      language:  cubit.localeLanguage==Locale('en')?'en':'ar',);
    if (ComplaintMessageModel.fromJson(res.data).success == false) {
      UserProfileCubit.get(context).changeUpdateLoading(false);
      showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.error, context: context);
    }
    else{
      if (res.statusCode == 200) {

        UserProfileCubit.get(context).changeUpdateLoading(false);
        UserProfileCubit.get(context).complainController.text='';
        showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.success, context: context);
        return ComplaintMessageModel.fromJson(res.data);
      }
      else {
        UserProfileCubit.get(context).changeUpdateLoading(false);
        showToast(text: '${ComplaintMessageModel.fromJson(res.data).message}', state: ToastStates.error, context: context);

        throw 'Error';
      }
    }
    return null;
  }



}
