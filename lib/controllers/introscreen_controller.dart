import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/introscreen_model.dart';
import '../utills/utills.dart';

class IntroAccessController extends GetxController {
  IntroAccess_Model introAccess_Model = IntroAccess_Model(
    introaccess: box.read('introaccess') ?? false,
  );

  introAccessControllerTrueValue({required bool val}) {
    introAccess_Model.introaccess = val;
    box.write('introaccess', introAccess_Model.introaccess);
    update();
  }
}
