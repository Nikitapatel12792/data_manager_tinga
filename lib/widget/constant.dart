import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_manager_tinga/Modal/PasswoedchangeModal.dart';
import 'package:data_manager_tinga/Modal/ProductCategoryModal.dart';
import 'package:data_manager_tinga/Modal/ProductsubCategoryModal.dart';
import 'package:data_manager_tinga/Modal/ProductsubsubCategory.dart';
import 'package:data_manager_tinga/Modal/StoreCAtegoryModal.dart';
import 'package:data_manager_tinga/Modal/UserModal.dart';



Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Color backc = Color(0xFFEAEEDE);
Color primary = Color(0xFF15161E);
Color secondary =Color(0xffFFFFFF);
Color secotext =Color(0xff606A85);
 String baseUrl ="https://beta.eduop.in/api" ;
UserModal? UserData;

PasswordChange? passwordchangemodal;

