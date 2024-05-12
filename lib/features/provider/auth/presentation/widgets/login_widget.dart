import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/resources/themes/styles/styles.dart';
import 'package:shart/widgets/custom_button.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../user/menu/logic/menu_cubit.dart';
import '../../logic/auth_provider_cubit.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviderCubit cubit = AuthProviderCubit.get(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: cubit.formKeyProvider,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 66.h,),
            Text(getLang(context, 'welcome_back'),
            style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
              fontFamily: FontConstants.lateefFont,
              fontSize: 25,
              fontWeight: FontWeight.w700
            ),
            ),
            Text(getLang(context, 'welcome_log'),
            style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
              fontFamily: FontConstants.lateefFont,
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
            ),
            SizedBox(height: 30.h,),
            CustomTextField(
              fillColor:  Colors.white,
              borderColor: Colors.white,
              hintText: '${getLang(context, 'phone')}',
              controller:  cubit.phoneControllerProvider,
              textInputType: TextInputType.phone,
              validationFunc: (String? val) {
                if (val!.length!=11) {
                  return '${getLang(context, 'sign_in_ver')}';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.phone,color: highGreyColor,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
              child: CustomTextField(
                fillColor:  Colors.white,
                borderColor: Colors.white,
                validationFunc: (String? val) {
                  if (val!.isEmpty) {
                    return '${getLang(context, 'sign_in_ver2')}';
                  }
                  return null;
                },
                isPassword: cubit.visibility ,
                prefixIcon: const Icon(Icons.lock_open,color: highGreyColor,),
                hintText: '${getLang(context, 'pass')}',
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller:cubit.passwordControllerProvider,
                suffixIcon: IconButton(
                  onPressed: () {
                   cubit.changeVisibilityIcon();
                  },
                  icon: Icon((cubit.visibility) ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: highGreyColor,),
                ),
                onFieldSubmitted: (String value){
                  MenuCubit.get(context).removeBanner('provider',context);
                  AuthProviderCubit.get(context).providerLogin(context);
                },
              ),
            ),

            SizedBox(height: 50.h,),
            BlocConsumer<AuthProviderCubit, AuthProviderState>(
                          listener: (BuildContext context, AuthProviderState state) {},
                          builder: (BuildContext context, AuthProviderState state) {
                            return CustomElevatedButton(
                                       isLoading: state is ProviderLoginLoadingState,
                                        onTap: (){
                                          MenuCubit.get(context).removeBanner('user',context);
                                          AuthProviderCubit.get(context).providerLogin(context);
                                        }, buttonText: getLang(context, 'login'));
                          },
                        ),
            SizedBox(height: 10.h,),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () =>  NavigationManager.push(Routes.providerForgetPassword), child:  Text('${getLang(context, 'pass2')}',
              style: TextStyles.font16GeryColor400WeightLateefFont.copyWith(
                color: blueColor,
                fontSize: 14
              ),
              )),
            ),
            SizedBox(height: 100.h,),

          ],
        ),
      ),
    );
  }
}