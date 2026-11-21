import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'backdrop_card_model.dart';
export 'backdrop_card_model.dart';

/// Wide cinematic card with backdrop image, used for trending.
class BackdropCardWidget extends StatefulWidget {
  const BackdropCardWidget({
    super.key,
    int? tmdbId,
    String? mediaType,
    String? title,
    String? backdropPath,
    double? voteAverage,
  })  : this.tmdbId = tmdbId ?? 0,
        this.mediaType = mediaType ?? 'movie',
        this.title = title ?? '',
        this.backdropPath = backdropPath ?? '',
        this.voteAverage = voteAverage ?? 0.0;

  final int tmdbId;
  final String mediaType;
  final String title;
  final String backdropPath;
  final double voteAverage;

  @override
  State<BackdropCardWidget> createState() => _BackdropCardWidgetState();
}

class _BackdropCardWidgetState extends State<BackdropCardWidget> {
  late BackdropCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackdropCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          MovieDetailsPageWidget.routeName,
          queryParameters: {
            'movieId': serializeParam(
              widget.tmdbId,
              ParamType.int,
            ),
            'mediaType': serializeParam(
              widget.mediaType,
              ParamType.String,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
            ),
          },
        );
      },
      child: Container(
        width: 300.0,
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional(-1.0, 1.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 500),
                fadeOutDuration: Duration(milliseconds: 500),
                imageUrl: ((String? p) {
                  return 'https://image.tmdb.org/t/p/w780${p}';
                }(widget.backdropPath)),
                width: 300.0,
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 300.0,
              height: 180.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    FlutterFlowTheme.of(context).tertiary
                  ],
                  stops: [0.35, 1.0],
                  begin: AlignmentDirectional(1.0, 0.0),
                  end: AlignmentDirectional(-1.0, 0),
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                  crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                        child: Text(
                          widget.mediaType == 'tv' ? 'TV SHOW' : 'MOVIE',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    Text(
                      widget.title,
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            font: GoogleFonts.sora(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 14.0,
                        ),
                        Text(
                          ((widget.voteAverage ?? 0).toStringAsFixed(1)),
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
