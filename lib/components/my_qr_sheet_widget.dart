import '/auth/firebase_auth/auth_util.dart';
import '/components/username_tag_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'my_qr_sheet_model.dart';
export 'my_qr_sheet_model.dart';

/// Bottom sheet with the current user's friend QR code and share link.
class MyQrSheetWidget extends StatefulWidget {
  const MyQrSheetWidget({super.key});

  @override
  State<MyQrSheetWidget> createState() => _MyQrSheetWidgetState();
}

class _MyQrSheetWidgetState extends State<MyQrSheetWidget> {
  late MyQrSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyQrSheetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              width: 44.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'wkjkihrm' /* My Yello code */,
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    font: GoogleFonts.sora(
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'unzeoq5n' /* Friends scan this code in Yell... */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).info,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24.0,
                    color: FlutterFlowTheme.of(context).accent1,
                    offset: Offset(
                      0.0,
                      8.0,
                    ),
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BarcodeWidget(
                  data: ((String? u) {
                    return 'https://movies-fglaj1.flutterflow.app/user?userId=' +
                        (u ?? '');
                  }(currentUserUid)),
                  barcode: Barcode.qrCode(),
                  width: 220.0,
                  height: 220.0,
                  color: FlutterFlowTheme.of(context).primaryText,
                  backgroundColor: FlutterFlowTheme.of(context).info,
                  errorBuilder: (_context, _error) => SizedBox(
                    width: 220.0,
                    height: 220.0,
                  ),
                  drawText: false,
                ),
              ),
            ),
            AuthUserStreamWidget(
              builder: (context) => Text(
                currentUserDisplayName,
                maxLines: 1,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.sora(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
              ),
            ),
            wrapWithModel(
              model: _model.myQrUsernameModel,
              updateCallback: () => safeSetState(() {}),
              child: UsernameTagWidget(
                userId: currentUserUid,
              ),
            ),
            Builder(
              builder: (context) => FFButtonWidget(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                      text: ((String? u) {
                    return 'Add me as a friend on Yello: ' +
                        'https://movies-fglaj1.flutterflow.app/user?userId=' +
                        (u ?? '');
                  }(currentUserUid))));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invite link copied',
                        style: TextStyle(),
                      ),
                      duration: Duration(milliseconds: 4000),
                    ),
                  );
                  await Share.share(
                    ((String? u) {
                      return 'Add me as a friend on Yello: ' +
                          'https://movies-fglaj1.flutterflow.app/user?userId=' +
                          (u ?? '');
                    }(currentUserUid)),
                    sharePositionOrigin: getWidgetBoundingBox(context),
                  );
                },
                text: FFLocalizations.of(context).getText(
                  'zzkha6qj' /* Share invite link */,
                ),
                icon: Icon(
                  Icons.ios_share_rounded,
                  size: 20.0,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).tertiary,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: TextStyle(
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
