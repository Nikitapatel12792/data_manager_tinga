import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_manager_tinga/Modal/LogoutModal.dart';
import 'package:data_manager_tinga/Modal/ProductDetailModal.dart';
import 'package:data_manager_tinga/Modal/UpcUpdateModal.dart';
import 'package:data_manager_tinga/pages/login/login_widget.dart';
import 'package:data_manager_tinga/provider/authprovider.dart';
import 'package:data_manager_tinga/provider/productprovider.dart';

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
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'products_details_page_model.dart';
export 'products_details_page_model.dart';

class ProductsDetailsPageWidget extends StatefulWidget {
  String? id;
  String? catid;
   ProductsDetailsPageWidget({Key? key,this.id,this.catid}) : super(key: key);

  @override
  _ProductsDetailsPageWidgetState createState() =>
      _ProductsDetailsPageWidgetState();
}
class HexColor extends Color {
  HexColor(int value) : super(value);

  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return HexColor(int.parse(hexColor, radix: 16));
  }
}
class _ProductsDetailsPageWidgetState extends State<ProductsDetailsPageWidget>
    with TickerProviderStateMixin {
  late ProductsDetailsPageModel _model;
String? barcord="";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    // Perform actions based on the selected index
    if (index == 0) {
      context.pushNamed(
          'Dashboard');
    } else if (index == 1) {
      context.pushNamed(
          'ChangePassword');
      // Handle Profile tap
      // Do something when Profile is tapped
    }
  }
  int _currentIndex = 0;
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
  ProductDetailModal? productdetail;
  @override
  void initState() {
    super.initState();
    productdetailap();
    _model = createModel(context, () => ProductsDetailsPageModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
            'Products Details',
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: Color(0xFFEAEEDE),
          selectedItemColor: FlutterFlowTheme.of(context).primaryText,
          unselectedItemColor: Color(0xFFBEBFC1),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_sharp,
                size: 24.0,
              ),
              label: 'Dashboard',
              tooltip: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.list_alt_sharp,
            //     size: 24.0,
            //   ),
            //   label: 'Products',
            //   tooltip: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.location_history_sharp,
                size: 24.0,
              ),
              label: 'Profile',
              tooltip: '',
            )
          ],
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.00, -1.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 5.0, 5.0, 5.0),
                                              child: Container(
                                                width: 175.0,
                                                height: 71.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'SKU : ' + (productdetail?.data?[0].sku == null || productdetail?.data?[0].sku =="" ?"N/A":productdetail?.data?[0].sku ?? ""),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Align(
                                                    //   alignment:
                                                    //       AlignmentDirectional(
                                                    //           -1.00, 0.00),
                                                    //   child: Padding(
                                                    //     padding:
                                                    //         EdgeInsetsDirectional
                                                    //             .fromSTEB(
                                                    //                 10.0,
                                                    //                 0.0,
                                                    //                 0.0,
                                                    //                 0.0),
                                                    //     child: Text(
                                                    //       'Loblaws',
                                                    //       style: FlutterFlowTheme
                                                    //               .of(context)
                                                    //           .bodyMedium
                                                    //           .override(
                                                    //             fontFamily:
                                                    //                 'Plus Jakarta Sans',
                                                    //             color: FlutterFlowTheme.of(
                                                    //                     context)
                                                    //                 .tertiary,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w600,
                                                    //           ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          _model.upccode!,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 5.0, 5.0, 5.0),
                                            child: Container(
                                              width: 175.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.70, -0.90),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    String? barcodeScanRes =
                                                    await FlutterBarcodeScanner
                                                        .scanBarcode(
                                                      '#C62828', // scanning line color
                                                      'Cancel', // cancel button text
                                                      true, // whether to show the flash icon
                                                      ScanMode.QR,
                                                    );
                                                    setState(() {
                                                      barcord = barcodeScanRes;
                                                    });

                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Scanned UPC Code'),
                                                                  content: Text(
                                                                    barcord!),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => updateap(productdetail?.data?[0].id.toString()),
                                                                      child: Text(
                                                                          'Save'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;

                                                    setState(() {});
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.barcode,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 48.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,

                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 10.0, 10.0, 10.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child:CachedNetworkImage(
                                              imageUrl: productdetail?.data?[0].image ?? "",
                                              placeholder: (context, url) =>
                                              const Center(
                                                  child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) =>
                                                  Image.network(
                                                      'https://picsum.photos/seed/793/600'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 15.0, 15.0, 15.0),
                                            child: Text(
                                              productdetail?.data?[0].name ?? "",
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 15.0, 15.0, 15.0),
                                              child: Text(
                                                '\$' + (productdetail?.data?[0].price).toString(),
                                                textAlign: TextAlign.end,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 15.0, 15.0, 15.0),
                                          child: Text(
                                            'Thumb Score : ${productdetail?.data?[0].thumbScore}',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color:FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 15.0, 0.0),
                                              child: Icon(
                                                Icons.thumb_up_alt,
                                                color: HexColor.fromHex((productdetail?.data?[0].thumbTypeColor).toString()),
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1.00, -1.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Product Detail',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.00, 0.00),
                                          child: Text(
                                            productdetail?.data?[0].description ?? "",
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                 Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Ingredients',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall,
                                      ),
                                      Text(
                                        productdetail?.data?[0].ingridients ?? "",
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
  productdetailap(){
    final Map<String, String> data = {};
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().productdetailapi(widget.id, widget.catid).then((Response response) async {
          productdetail = ProductDetailModal.fromJson(json.decode(response.body));

         
          if (response.statusCode == 200 && productdetail?.success == true ) {
            setState(() {
              // isLoading = false;
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
  updateap(String? val){

    final Map<String, String> data = {};

    data['store_id'] = productdetail?.data?[0].id == null? "":(productdetail?.data?[0].id).toString();
    data['upc'] =barcord.toString();
    data['product_id'] = val.toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().upcupdateapi(data).then((
            Response response) async {
          UpcUpdateModal update = UpcUpdateModal.fromJson(
              json.decode(response.body));
          print(response.body);
          if (response.statusCode == 200 ) {
            print("succ");
            Navigator.of(context).pop();
          } else {}
        });
      } else {
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
