import 'package:flutter/material.dart';
import '../../../../../shared_screens/favorite/custom_favorite_screen.dart';
import '../../../../../shared_screens/visitor_screen/visitor_screen.dart';
import '../../../auth/logic/auth_provider_cubit.dart';
import '../../../bottom_nav/presentation/screens/bottom_nav.dart';

class ProviderFavoriteScreen extends StatelessWidget {
  const ProviderFavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return PopScope(
        canPop: false,
        onPopInvoked: (_) async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProviderBottomNavScreen(
                checkPage: '0',
              )));
        },
        child:
        CustomFavoriteScreen(type: 'provider',));
  }
}
