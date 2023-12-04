import 'dart:convert';

import 'package:data_manager_tinga/Modal/LogoutModal.dart';
import 'package:data_manager_tinga/Modal/PasswoedchangeModal.dart';
import 'package:data_manager_tinga/index.dart';
import 'package:data_manager_tinga/provider/authprovider.dart';

import 'package:data_manager_tinga/widget/constant.dart';
import 'package:data_manager_tinga/widget/sharedpreferance.dart';
import 'package:http/http.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'change_password_model.dart';
export 'change_password_model.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget>
    with TickerProviderStateMixin {
  late ChangePasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0.698, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    getdata();
    _model = createModel(context, () => ChangePasswordModel());

    _model.newPasswordController ??= TextEditingController();
    _model.newPasswordFocusNode ??= FocusNode();

    _model.retypePasswordController ??= TextEditingController();
    _model.retypePasswordFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }
getdata()async{
  UserData= await  SaveDataLocal.getDataFromLocal();
}
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme
              .of(context)
              .brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () =>
      _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFEAEEDE),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme
              .of(context)
              .secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Change Password',
            style: FlutterFlowTheme
                .of(context)
                .headlineMedium,
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 10.0),
              child: FlutterFlowIconButton(
                borderColor: Color(0x0015161E),
                borderWidth: 1.0,
                buttonSize: 60.0,
                fillColor: Color(0xFFE1E9C7),
                hoverColor: FlutterFlowTheme
                    .of(context)
                    .primaryText,
                hoverIconColor: Color(0xFFEAEEDE),
                icon: Icon(
                  Icons.logout,
                  color: FlutterFlowTheme
                      .of(context)
                      .primaryText,
                  size: 20.0,
                ),
                onPressed: () {
                  logoutap();
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme
                          .of(context)
                          .secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 200.0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              8.0, 10.0, 8.0, 10.0),
                                          child: TextFormField(
                                            controller:
                                            _model.newPasswordController,
                                            focusNode:
                                            _model.newPasswordFocusNode,
                                            autofocus: true,
                                            obscureText:
                                            !_model.newPasswordVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Type New Password',
                                              labelStyle:
                                              FlutterFlowTheme
                                                  .of(context)
                                                  .labelMedium,
                                              hintStyle:
                                              FlutterFlowTheme
                                                  .of(context)
                                                  .labelMedium,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .alternate,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE1E9C7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.password_sharp,
                                                color:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .primaryText,
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: () =>
                                                    setState(
                                                          () =>
                                                      _model
                                                          .newPasswordVisibility =
                                                      !_model
                                                          .newPasswordVisibility,
                                                    ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model.newPasswordVisibility
                                                      ? Icons
                                                      .visibility_outlined
                                                      : Icons
                                                      .visibility_off_outlined,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme
                                                .of(context)
                                                .bodyMedium,
                                            validator: (val){
                                              if(val!.isEmpty){
                                                return "Enter newpassword";

                                              }
                                              return null;
                                            }
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              8.0, 10.0, 8.0, 10.0),
                                          child: TextFormField(
                                            controller:
                                            _model.retypePasswordController,
                                            focusNode:
                                            _model.retypePasswordFocusNode,
                                            autofocus: true,
                                            obscureText:
                                            !_model.retypePasswordVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'ReType New Password',
                                              labelStyle:
                                              FlutterFlowTheme
                                                  .of(context)
                                                  .labelMedium,
                                              hintStyle:
                                              FlutterFlowTheme
                                                  .of(context)
                                                  .labelMedium,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .alternate,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE1E9C7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.password_sharp,
                                                color:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .primaryText,
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: () =>
                                                    setState(
                                                          () =>
                                                      _model
                                                          .retypePasswordVisibility =
                                                      !_model
                                                          .retypePasswordVisibility,
                                                    ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model
                                                      .retypePasswordVisibility
                                                      ? Icons
                                                      .visibility_outlined
                                                      : Icons
                                                      .visibility_off_outlined,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme
                                                .of(context)
                                                .bodyMedium,
                                            validator: (val){
                                              if(val!.isEmpty){
                                                return "Enter Re type password";

                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(1.00, 0.00),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 10.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                print("dsnvdsmn");
                                                chagepasswordap();

                                              },
                                              text: 'Change Password',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                                iconPadding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                                color:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .primaryText,
                                                textStyle:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .titleSmall
                                                    .override(
                                                  fontFamily:
                                                  'Plus Jakarta Sans',
                                                  color: Colors.white,
                                                ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  chagepasswordap() async{
    print("vnfvdn");
    if (formKey.currentState!.validate()) {
      final Map<String, String> data = {};

      data['password'] = _model.retypePasswordController.text.trim().toString();
        if(_model.retypePasswordController.text.toString() == _model.newPasswordController.text.toString()) {
          checkInternet().then((internet) async {
            if (internet) {
              authprovider().passwordchangeapi(data).then((
                  Response response) async {
                PasswordChange passwordchangemodal = PasswordChange.fromJson(
                    json.decode(response.body));
                  print(response.body);
                if (response.statusCode == 200) {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text(
                            'Password Updated'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  alertDialogContext);
                            },
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Password Change Successfully'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  alertDialogContext);
                            },
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            } else {
              setState(() {
                // isLoading = false;
              });
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(
                        'Internet required.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              alertDialogContext);
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          });
        }
        else{
          await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Both Password should be same'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        alertDialogContext);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
          );
        }
    }
  }
  logoutap(){
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().logoutapi().then((
            Response response) async {
          LogoutModal logoutmodal = LogoutModal.fromJson(
              json.decode(response.body));
          print(response.body);
          if (response.statusCode == 200) {
            SaveDataLocal.clearUserData();
            UserData =await SaveDataLocal.getDataFromLocal();
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginWidget()));
          } else {

          }
        });
      } else {
        setState(() {
          // isLoading = false;
        });
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  ' Internet required.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        alertDialogContext);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
