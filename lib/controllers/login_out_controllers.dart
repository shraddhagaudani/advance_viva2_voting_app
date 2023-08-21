
import 'package:get/get.dart';
import '../models/login_out.dart';
import '../utills/utills.dart';

class LogINOutController  {
  LoginInOutModel loginInOutModel =
      LoginInOutModel(islogin: box.read('islogin') ?? false);

  logInOutTrueValue() {
    loginInOutModel.islogin = true;

    box.write('islogin', loginInOutModel.islogin);
  }

  logInOutFalseValue(){
    loginInOutModel.islogin = false;

    box.write('islogin', loginInOutModel.islogin);

  }
}
