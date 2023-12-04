import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'change_password_widget.dart' show ChangePasswordWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordModel extends FlutterFlowModel<ChangePasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for NewPassword widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordControllerValidator;
  // State field(s) for RetypePassword widget.
  FocusNode? retypePasswordFocusNode;
  TextEditingController? retypePasswordController;
  late bool retypePasswordVisibility;
  String? Function(BuildContext, String?)? retypePasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    newPasswordVisibility = false;
    retypePasswordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    newPasswordFocusNode?.dispose();
    newPasswordController?.dispose();

    retypePasswordFocusNode?.dispose();
    retypePasswordController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
