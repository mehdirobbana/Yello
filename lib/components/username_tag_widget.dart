import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'username_tag_model.dart';
export 'username_tag_model.dart';

/// Shows @username for a user id.
///
/// Hidden when the user has none.
class UsernameTagWidget extends StatefulWidget {
  const UsernameTagWidget({
    super.key,
    String? userId,
  }) : this.userId = userId ?? '';

  final String userId;

  @override
  State<UsernameTagWidget> createState() => _UsernameTagWidgetState();
}

class _UsernameTagWidgetState extends State<UsernameTagWidget> {
  late UsernameTagModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UsernameTagModel());

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
      child: StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) => usersRecord.where(
            'uid',
            isEqualTo: widget.userId,
          ),
          limit: 1,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).secondary,
                  ),
                ),
              ),
            );
          }
          List<UsersRecord> usernameQueryUsersRecordList = snapshot.data!;

          return Builder(
            builder: (context) {
              final listItem = usernameQueryUsersRecordList.toList();

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: List.generate(listItem.length, (listItemIndex) {
                  final listItemItem = listItem[listItemIndex];
                  return Visibility(
                    visible: ((String? u) {
                          return (u ?? '').isNotEmpty;
                        }(listItemItem.username)) ??
                        true,
                    child: Text(
                      ((String? u) {
                        return '@' + (u ?? '');
                      }(listItemItem.username)),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
