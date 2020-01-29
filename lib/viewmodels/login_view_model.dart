import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/authentication-service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'base_model.dart';
import 'package:compound/services/dialog_service.dart';


class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService= locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  Future login({
    @required String email,
    @required String password,
  })async{
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
      email:email,
      password:password,
    );
    setBusy(false);
    if (result is bool) {
      if (result){
        _navigationService.navigateTo(HomeViewRoute);
      }else{
        await _dialogService.showDialog(
          title: 'НЕПОЛУЧИЛОСЬ ',
          description: 'что то пошло не так попробуйте позже',
        );
      }
    }else{
      await _dialogService.showDialog(
        title: 'НЕПОЛУЧИЛОСЬ ',
        description: result,
      );
    }
  }
}