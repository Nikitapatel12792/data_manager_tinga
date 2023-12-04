import 'dart:convert';

import 'package:data_manager_tinga/Modal/GetdataModal.dart';
import 'package:data_manager_tinga/Modal/LogoutModal.dart';
import 'package:data_manager_tinga/Modal/ProductCategoryModal.dart';
import 'package:data_manager_tinga/Modal/ProductsubCategoryModal.dart';
import 'package:data_manager_tinga/Modal/ProductsubsubCategory.dart';
import 'package:data_manager_tinga/Modal/StoreCAtegoryModal.dart';
import 'package:data_manager_tinga/pages/login/login_widget.dart';
import 'package:data_manager_tinga/pages/products_listing_page/products_listing_page_widget.dart';
import 'package:data_manager_tinga/provider/authprovider.dart';
import 'package:data_manager_tinga/provider/productprovider.dart';
import 'package:data_manager_tinga/widget/constant.dart';
import 'package:data_manager_tinga/widget/load.dart';
import 'package:data_manager_tinga/widget/sharedpreferance.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dashboard_model.dart';
export 'dashboard_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}
class store{
  String id;
  String name;
  store(this.id,this.name);
}
class category{
  String id;
  String name;
  category(this.id,this.name);
}
class subcatpro{
  String id;
  String name;
  subcatpro(this.id,this.name);
}
class subsubcatpro{
  String id;
  String name;
  subsubcatpro(this.id,this.name);
}
class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;

  GetdataModal? getdatamodal;
  List<store?> str=[];
  List<category?> cat=[];
  List<subcatpro?> subcat=[];
  List<subsubcatpro?> subsubcat=[];
  StorecategoryModal? storemodal;
  ProductCategoryModal? productcategory;
  ProductsubCategory? subcategory;
  ProductsubsubcategoryModal? subsubcategorymodal;
  String? selectedItem;
  String? selectedItem1;
  String? selectedItem2;
  String? selectedItem3;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
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
    print("inistatecall");
    getuser();

    _model = createModel(context, () => DashboardModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }
getuser()async{
setState(() {


  selectedItem=null;
  print("enter");

});
      UserData=await SaveDataLocal.getDataFromLocal();
  getdataap();
  storeap();
  catogeryap();
}
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFEAEEDE),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              'Dashboard',
              style: FlutterFlowTheme.of(context).headlineMedium,
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 10.0),
                child: FlutterFlowIconButton(
                  borderColor: Color(0x0015161E),
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  fillColor: Color(0xFFE1E9C7),
                  hoverColor: FlutterFlowTheme.of(context).primaryText,
                  hoverIconColor: Color(0xFFEAEEDE),
                  icon: Icon(
                    Icons.logout,
                    color: FlutterFlowTheme.of(context).primaryText,
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
          body:SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 140.0,
                    constraints: BoxConstraints(
                      maxHeight: 140.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 1.0),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Below is a summary of scanned products.',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 8.0, 8.0),
                                    child: Container(
                                      width: 130.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (getdatamodal?.data?.total).toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                              child: Text(
                                                'Total Scanned',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 8.0),
                                    child: Container(
                                      width: 130.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (getdatamodal?.data?.today).toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .tertiary,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                              child: Text(
                                                'Today Scanned',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 16.0, 8.0),
                                    child: Container(
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (getdatamodal?.data?.monthly).toString(),
                                              style: FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily: 'Outfit',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondary,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                              child: Text(
                                                'Monthly Scanned',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x33000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 0, 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 15),
                                          child: Text(
                                            'Select Store & Category to get product list',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium,
                                          ),
                                        ),
                                        Form(
                                          key: _model.formKey,
                                          autovalidateMode:
                                          AutovalidateMode.disabled,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                                child:
                                                Container(
                                                  width: 322.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color:
                                                      FlutterFlowTheme.of(context)
                                                          .alternate,
                                                      width: 2,
                                                    ),
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(

                                                      iconStyleData: IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                      hint: Text("Select Store"),
                                                      value: selectedItem,
                                                      onChanged: (String? newValue1) {
                                                        setState(() {
                                                          selectedItem =
                                                              newValue1; // Update the selectedItem
                                                        });

                                                      },
                                                      items: storemodal?.data?.map((item) {
                                                        return DropdownMenuItem<String>(
                                                          value: item.id.toString(),
                                                          child: Text(
                                                            item?.name ?? "",
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                                child:
                                                Container(
                                                  width: 322.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color:
                                                      FlutterFlowTheme.of(context)
                                                          .alternate,
                                                      width: 2,
                                                    ),
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(
                                                      isExpanded: true,
                                                      iconStyleData: IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                      hint: Text("Select Category"),
                                                      value: selectedItem1,
                                                      onChanged: (String? newValue1) {
                                                        setState(() {
                                                          selectedItem1 =
                                                              newValue1; // Update the selectedItem
                                                        });
                                                          print(selectedItem1);
                                                        selectedItem2=null;
                                                        selectedItem3=null;
                                                        print("issue");
                                                        print(selectedItem2);
                                                        print(selectedItem3);
                                                        subcategoryap(selectedItem1.toString());
                                                      },
                                                      items: productcategory?.data?.map((item) {
                                                        return DropdownMenuItem<String>(
                                                          value: item.id.toString(),
                                                          child: Text(
                                                            item?.name ?? "",
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                                child:
                                                Container(
                                                  width: 322.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color:
                                                      FlutterFlowTheme.of(context)
                                                          .alternate,
                                                      width: 2,
                                                    ),
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(

                                                      isExpanded: true,
                                                      iconStyleData: IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                      hint: Text("Select Sub Category"),
                                                      value: selectedItem2,
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          selectedItem2 = newValue;
                                                        });
                                                          selectedItem3 =null;
                                                        subsubcategoryap(selectedItem2.toString());
                                                      },
                                                      items:subcategory?.data?.map((item) {
                                                        return DropdownMenuItem<String>(
                                                          value: item.id.toString(),
                                                          child: Text(
                                                            item?.name ?? "",
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                                child:
                                                Container(
                                                  width: 322.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color:
                                                      FlutterFlowTheme.of(context)
                                                          .alternate,
                                                      width: 2,
                                                    ),
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton2<String>(
                                                      isExpanded: true,
                                                      iconStyleData: IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                      hint: Text("Select Sub Sub Category"),
                                                      value: selectedItem3,
                                                      onChanged: (String? newValue1) {
                                                        setState(() {
                                                          selectedItem3 =
                                                              newValue1; // Update the selectedItem
                                                        });

                                                      },
                                                      items: subsubcategorymodal?.data?.map((item) {
                                                        return DropdownMenuItem<String>(
                                                          value: item.id.toString(),
                                                          child: Text(
                                                            item?.name ?? "",
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              selectedItem==null||selectedItem1==null?Container():FFButtonWidget(
                                                onPressed: () async {


                                                  String? cat1 =selectedItem1.toString();
                                                  String? str1=selectedItem.toString();
                                                  String? subcat1=selectedItem2.toString();
                                                  String? subsubcst1 =selectedItem3.toString();
                                                  // selectedItem?.id ="";
                                                  // selectedItem1?.id="";
                                                  selectedItem2="";
                                                  selectedItem3="";
                                                   subcat=[];
                                                   subsubcat=[];                                             context.pushNamed(
                                                    'ProductsListingPage',
                                                    queryParameters: {
                                                      'catid': serializeParam(
                                                        cat1,
                                                        ParamType.String,
                                                      ),
                                                      'subcatid': serializeParam(
                                                        subcat1,
                                                        ParamType.String,
                                                      ),
                                                      'subsubcatid': serializeParam(
                                                       subsubcst1,
                                                        ParamType.String,
                                                      ),
                                                      'storeid': serializeParam(
                                                        str1,
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                text: 'Get products for scanning',
                                                options: FFButtonOptions(
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.8,
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  iconPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                  textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color: Colors.white,
                                                  ),
                                                  elevation: 3,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
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
                          ],
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation4']!),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
  storeap(){
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().storeapi().then((
            Response response) async {
          storemodal  = StorecategoryModal.fromJson(
              json.decode(response.body));
          if (response.statusCode == 200&& storemodal?.success ==true) {
            // for (int i = 0;
            // i < int.parse((storemodal?.data?.length).toString());
            // i++) {
            //   print(i);
            //   str.add(store((storemodal?.data?[i].id).toString(),
            //       (storemodal?.data?[i].name).toString()));
            //
            // }
            // setState(() {
            //
            //     str;
            //
            //
            // });
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
  getdataap(){

    checkInternet().then((internet) async {
      if (internet) {
        productprovider().getdataapi().then((
            Response response) async {
          getdatamodal  = GetdataModal.fromJson(
              json.decode(response.body));
          print("data");
          print(response.body);
          if (response.statusCode == 200&& getdatamodal?.success ==true) {
            setState((){
              getdatamodal;
            });

          } else {
            setState(() {


            });
          }
        });
      } else {
        setState(() {

        });
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'No Internet available.'),
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
  catogeryap(){
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().categoryapi().then((
            Response response) async {
          productcategory  = ProductCategoryModal.fromJson(
              json.decode(response.body));

          if (response.statusCode == 200&& productcategory?.success ==true) {


            // cat.clear();
            // for (int i = 0;
            // i < int.parse((productcategory?.data?.length).toString());
            // i++) {
            //   cat.add(category((productcategory?.data?[i].id).toString(),
            //       (productcategory?.data?[i].name).toString()));
            // }
            // setState(() {
            //   // cat.clear();
            //  cat;
            // });
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
                  'No Internet available.'),
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
  subcategoryap(String val){
    print("subsubcat");
    final Map<String, String> data = {};
    data['category_id'] = val.toString();
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().subcategoryapi(data).then((
            Response response) async {
          subcategory  = ProductsubCategory.fromJson(
              json.decode(response.body));

          if (response.statusCode == 200&& subcategory?.success ==true) {
            print("success");

         //    List<subcatpro> newSubSubCatList = [];
         //    for (int i = 0;
         //    i < int.parse((subcategory?.data?.length).toString());
         //    i++) {
         //      newSubSubCatList.add(subcatpro((subcategory?.data?[i].id).toString(),
         //          (subcategory?.data?[i].name).toString()));
         //    }
         //
            setState(() {
              subcategory;
            });
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
                  'No Internet available.'),
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
  subsubcategoryap(String val){
    final Map<String, String> data = {};
    data['category_id'] = (selectedItem1).toString();
    data['subcategory_id'] = (selectedItem2).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().subsubcategoryapi(data).then((
            Response response) async {
          subsubcategorymodal  = ProductsubsubcategoryModal.fromJson(
              json.decode(response.body));

        print(response.body);
          if (response.statusCode == 200&& subsubcategorymodal?.success ==true) {

            // List<subsubcatpro> newSubSubCatList = [];
            // for (int i = 0;
            // i < int.parse((subsubcategorymodal?.data?.length).toString());
            // i++) {
            //   newSubSubCatList.add(subsubcatpro((subsubcategorymodal?.data?[i].id).toString(),
            //       (subsubcategorymodal?.data?[i].name).toString()));
            // }
            setState(() {

              subsubcategorymodal;
            });
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
                  'No Internet available.'),
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
  logoutap(){
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().logoutapi().then((
            Response response) async {
          LogoutModal logoutmodal = LogoutModal.fromJson(
              json.decode(response.body));

          if (response.statusCode == 200) {
            SaveDataLocal.clearUserData();
         
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
                  'No Internet available.'),
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
