import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'username_gate_model.dart';
export 'username_gate_model.dart';

/// Zero-size helper on Discover.
///
/// If the user has no username it opens the one-time Choose your username
/// page.
class UsernameGateWidget extends StatefulWidget {
  const UsernameGateWidget({super.key});

  @override
  State<UsernameGateWidget> createState() => _UsernameGateWidgetState();
}

class _UsernameGateWidgetState extends State<UsernameGateWidget> {
  late UsernameGateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UsernameGateModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.gateMe2 = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (((String? id, String? u) {
        return (id ?? '').isNotEmpty && (u ?? '').trim().isEmpty;
      }(currentUserUid, _model.gateMe2?.username))) {
        context.goNamed(
          UsernamePageWidget.routeName,
          queryParameters: {
            'isGate': serializeParam(
              true,
              ParamType.bool,
            ),
          }.withoutNulls,
        );
      }
    });

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
      width: 0.0,
      height: 0.0,
    );
  }
}
