import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'avatar_picker_sheet_model.dart';
export 'avatar_picker_sheet_model.dart';

/// Pick one of 12 avatars to use as your profile photo.
class AvatarPickerSheetWidget extends StatefulWidget {
  const AvatarPickerSheetWidget({super.key});

  @override
  State<AvatarPickerSheetWidget> createState() =>
      _AvatarPickerSheetWidgetState();
}

class _AvatarPickerSheetWidgetState extends State<AvatarPickerSheetWidget> {
  late AvatarPickerSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvatarPickerSheetModel());

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
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                'm529imqg' /* Choose your avatar */,
              ),
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Felix',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Felix',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Aneka',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Aneka',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Milo',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Milo',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Luna',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Luna',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Ravi',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Ravi',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Nora',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Nora',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Kai',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Kai',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Sofia',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Sofia',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Amir',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Amir',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Iris',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Iris',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Leo',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Leo',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await currentUserReference!.update(createUsersRecordData(
                      photoUrl:
                          'https://api.dicebear.com/9.x/adventurer/png?seed=Maya',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Avatar updated',
                          style: TextStyle(),
                        ),
                        duration: Duration(milliseconds: 4000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 76.0,
                    height: 76.0,
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeOutDuration: Duration(milliseconds: 500),
                        imageUrl:
                            'https://api.dicebear.com/9.x/adventurer/png?seed=Maya',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
