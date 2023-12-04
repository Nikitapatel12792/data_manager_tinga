import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_manager_tinga/Modal/LogoutModal.dart';
import 'package:data_manager_tinga/Modal/ProductListModal.dart';
import 'package:data_manager_tinga/Modal/SearchModal.dart';
import 'package:data_manager_tinga/Modal/UpcUpdateModal.dart';
import 'package:data_manager_tinga/pages/login/login_widget.dart';
import 'package:data_manager_tinga/pages/products_details_page/products_details_page_widget.dart';
import 'package:data_manager_tinga/provider/authprovider.dart';
import 'package:data_manager_tinga/provider/productprovider.dart';
import 'package:data_manager_tinga/widget/bottom.dart';

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
import 'products_listing_page_model.dart';
export 'products_listing_page_model.dart';

class ProductsListingPageWidget extends StatefulWidget {
  const ProductsListingPageWidget({
    Key? key,
    String? storeid,
    String? catid,
    String? subcatid,
    String? subsubcatid,
  })  : this.storeid = storeid ?? '\"\"',
        this.catid = catid ?? '\"\"',
        this.subcatid = subcatid ?? '\"\"',
        this.subsubcatid = subsubcatid ?? '\"\"',
        super(key: key);

  final String storeid;
  final String catid;
  final String subcatid;
  final String subsubcatid;

  @override
  _ProductsListingPageWidgetState createState() =>
      _ProductsListingPageWidgetState();
}

class _ProductsListingPageWidgetState extends State<ProductsListingPageWidget>
    with TickerProviderStateMixin {
  late ProductsListingPageModel _model;
  String? barcode = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
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
    'containerOnPageLoadAnimation2': AnimationInfo(
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
  ProductListModal?  productlist;
  String? _search="";
  @override
  void initState() {
    super.initState();

    productlistingap();
    _model = createModel(context, () => ProductsListingPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }
  SearchModal? searchModal;
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
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
        key: scaffoldKey,
        backgroundColor: Color(0xFFEAEEDE),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Products Listing',
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
        body: SafeArea(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                            'Below is a summary of scanned products.',
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),

                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          obscureText: false,
                          onChanged: (value){
                            setState(() {
                              _search=value;
                            });
                            print(value);
                            searchap();
                          },
                          decoration: InputDecoration(
                            labelText: 'Search Product Name',
                            labelStyle:
                                FlutterFlowTheme.of(context).labelMedium,
                            hintStyle: FlutterFlowTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE1E9C7),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ],
                  ),
                ),
                _model.textController.text == "" ? Container():
                searchModal?.success ==false ?Text("No Product ."): Column(
                  children: [
                    for(int index=0;index<(searchModal?.data?.length ?? 0);index++)...[
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
                          child:
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
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
                                                                'SKU : ${searchModal?.data?[index].sku}',
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
                                                          //   AlignmentDirectional(
                                                          //       -1.00, 0.00),
                                                          //   child: Padding(
                                                          //     padding:
                                                          //     EdgeInsetsDirectional
                                                          //         .fromSTEB(
                                                          //         10.0,
                                                          //         0.0,
                                                          //         0.0,
                                                          //         0.0),
                                                          //     child: Text(
                                                          //       'Loblaws',
                                                          //       style: FlutterFlowTheme
                                                          //           .of(context)
                                                          //           .bodyMedium
                                                          //           .override(
                                                          //         fontFamily:
                                                          //         'Plus Jakarta Sans',
                                                          //         color: FlutterFlowTheme.of(
                                                          //             context)
                                                          //             .tertiary,
                                                          //         fontWeight:
                                                          //         FontWeight
                                                          //             .w600,
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          // Align(
                                                          //   alignment:
                                                          //   AlignmentDirectional(
                                                          //       -1.00, 0.00),
                                                          //   child: Padding(
                                                          //     padding:
                                                          //     EdgeInsetsDirectional
                                                          //         .fromSTEB(
                                                          //         10.0,
                                                          //         0.0,
                                                          //         0.0,
                                                          //         0.0),
                                                          //     child: Text(
                                                          //       _model.upccode!,
                                                          //       style: FlutterFlowTheme
                                                          //           .of(context)
                                                          //           .bodyMedium
                                                          //           .override(
                                                          //         fontFamily:
                                                          //         'Plus Jakarta Sans',
                                                          //         color: FlutterFlowTheme.of(
                                                          //             context)
                                                          //             .tertiary,
                                                          //         fontWeight:
                                                          //         FontWeight
                                                          //             .w600,
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
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
                                                            barcode = barcodeScanRes;
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
                                                                        barcode!),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: (){
                                                                        updateap(searchModal?.data?[index].id.toString());
                                                                      },

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
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(builder:
                                                            (context)=>ProductsDetailsPageWidget(catid:searchModal?.data?[index].storeId.toString(),
                                                          id: searchModal?.data?[index].id.toString(),)));

                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(8.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: searchModal?.data?[index].image ?? "",
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
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      15.0, 15.0, 15.0, 15.0),
                                                  child: InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(builder:
                                                              (context)=>ProductsDetailsPageWidget(catid:searchModal?.data?[index].storeId.toString(),
                                                            id: searchModal?.data?[index].id.toString(),)));
                                            
                                                    },
                                                    child: Text(
                                                      searchModal?.data?[index].name ?? "",
                                                      style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                        15.0, 15.0, 15.0, 15.0),
                                                    child: Text(
                                                      "\$"+(searchModal?.data?[index].price).toString(),
                                                      textAlign: TextAlign.end,
                                                      style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium,
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

                              ],
                            ),
                          ),
                        ),
                      ),
                    ]

                  ],
                ),
                _model.textController.text != ""?Container(): productlist?.success ==false ?Text("No Product."): Column(
                  children: [
                  for(int index=0;index<(productlist?.data?.length ?? 0);index++)...[
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
                      child:
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
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
                                                            'SKU : '+(productlist?.data?[index].sku == null || productlist?.data?[index].sku== ""?"N/A": (productlist?.data?[index].sku).toString()),
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
                                                      //   AlignmentDirectional(
                                                      //       -1.00, 0.00),
                                                      //   child: Padding(
                                                      //     padding:
                                                      //     EdgeInsetsDirectional
                                                      //         .fromSTEB(
                                                      //         10.0,
                                                      //         0.0,
                                                      //         0.0,
                                                      //         0.0),
                                                      //     child: Text(
                                                      //       'Loblaws',
                                                      //       style: FlutterFlowTheme
                                                      //           .of(context)
                                                      //           .bodyMedium
                                                      //           .override(
                                                      //         fontFamily:
                                                      //         'Plus Jakarta Sans',
                                                      //         color: FlutterFlowTheme.of(
                                                      //             context)
                                                      //             .tertiary,
                                                      //         fontWeight:
                                                      //         FontWeight
                                                      //             .w600,
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // Align(
                                                      //   alignment:
                                                      //   AlignmentDirectional(
                                                      //       -1.00, 0.00),
                                                      //   child: Padding(
                                                      //     padding:
                                                      //     EdgeInsetsDirectional
                                                      //         .fromSTEB(
                                                      //         10.0,
                                                      //         0.0,
                                                      //         0.0,
                                                      //         0.0),
                                                      //     child: Text(
                                                      //       _model.upccode!,
                                                      //       style: FlutterFlowTheme
                                                      //           .of(context)
                                                      //           .bodyMedium
                                                      //           .override(
                                                      //         fontFamily:
                                                      //         'Plus Jakarta Sans',
                                                      //         color: FlutterFlowTheme.of(
                                                      //             context)
                                                      //             .tertiary,
                                                      //         fontWeight:
                                                      //         FontWeight
                                                      //             .w600,
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
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
                                                        barcode = barcodeScanRes;
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
                                                                    barcode!),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () => Navigator.pop(
                                                                        alertDialogContext,
                                                                        false),
                                                                    child: Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: (){
                                                                      print("save");
                                                                      print(widget.storeid);
                                                                      print(barcode);
                                                                      print(productlist?.data?[index].id);
                                                                      updateap(productlist?.data?[index].id.toString());
                                                                    },
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
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                // context.pushNamed(
                                                //     'ProductsDetailsPage');
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder:
                                                        (context)=>ProductsDetailsPageWidget(catid:productlist?.data?[index].storeId.toString(),
                                                        id: productlist?.data?[index].id.toString(),)));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: productlist?.data?[index].image ?? "",
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
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                       Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 15.0, 15.0, 15.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  // context.pushNamed(
                                                  //     'ProductsDetailsPage');
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (context)=>ProductsDetailsPageWidget(catid:productlist?.data?[index].storeId.toString(),
                                                        id: productlist?.data?[index].id.toString(),)));
                                        
                                                },
                                                child: Text(
                                                  productlist?.data?[index].name == null || productlist?.data?[index].name == "" ? "N/A" :(productlist?.data?[index].name).toString(),
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                    15.0, 15.0, 15.0, 15.0),
                                                child: Text(
                                                  "\$"+(productlist?.data?[index].price == ""|| productlist?.data?[index].price == null ?"N/A":(productlist?.data?[index].price).toString()),
                                                  textAlign: TextAlign.end,
                                                  style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
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

                          ],
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation1']!),
                  ),
                ]

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  productlistingap(){

      final Map<String, String> data = {};
      data['category_id'] = widget.catid == null?"0":widget.catid.toString();
      data['store_id'] = widget.storeid == null? "0":widget.storeid.toString();
      data['subcategory_id'] =widget.subcatid == null ?"0":widget.subcatid.toString();
      data['subsubcategory_id'] = widget.subsubcatid == null?"0":widget.subsubcatid.toString();
    data['offset'] = "1";
      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          productprovider().productlistingapi(data).then((Response response) async {
           productlist = ProductListModal.fromJson(json.decode(response.body));
           print(response.body);
            if (response.statusCode == 200 && productlist?.success == true ) {
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
  searchap(){
    print("search");
    final Map<String, String> data = {};
    data['category_id'] = widget.catid == null?"0":widget.catid.toString();
    data['store_id'] = widget.storeid == null? "0":widget.storeid.toString();
    data['subcategory_id'] =widget.subcatid == null ?"0":widget.subcatid.toString();
    data['subsubcategory_id'] = widget.subsubcatid == null?"0":widget.subsubcatid.toString();
    data['name'] = _search.toString();
    data['code'] = "";
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().searchapi(data).then((
            Response response) async {
           searchModal = SearchModal.fromJson(
              json.decode(response.body));

          if (response.statusCode == 200 && searchModal?.success == true) {

              setState(() {
                searchModal;
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
  updateap(String? val){
    final Map<String, String> data = {};
    data['store_id'] =widget.storeid;
    data['upc'] =barcode.toString();
    data['product_id'] = val.toString();
    print("hiii");
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        productprovider().upcupdateapi(data).then((
            Response response) async {
          UpcUpdateModal update = UpcUpdateModal.fromJson(
              json.decode(response.body));
          print(response.body);
          if (response.statusCode == 200 ) {
              _model.textController.text="";
              _search="";
            productlistingap();
            Navigator.of(context).pop();
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
