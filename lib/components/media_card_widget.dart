import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'media_card_model.dart';
export 'media_card_model.dart';

/// Poster card for a movie or TV show; opens its details.
class MediaCardWidget extends StatefulWidget {
  const MediaCardWidget({
    super.key,
    int? tmdbId,
    String? mediaType,
    String? title,
    String? posterPath,
    double? voteAverage,
  })  : this.tmdbId = tmdbId ?? 0,
        this.mediaType = mediaType ?? 'movie',
        this.title = title ?? '',
        this.posterPath = posterPath ?? '',
        this.voteAverage = voteAverage ?? 0.0;

  final int tmdbId;
  final String mediaType;
  final String title;
  final String posterPath;
  final double voteAverage;

  @override
  State<MediaCardWidget> createState() => _MediaCardWidgetState();
}

class _MediaCardWidgetState extends State<MediaCardWidget> {
  late MediaCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaCardModel());

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
        width: 130.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Stack(
              alignment: AlignmentDirectional(-1.0, -1.0),
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12.0,
                        color: FlutterFlowTheme.of(context).alternate,
                        offset: Offset(
                          0.0,
                          6.0,
                        ),
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageUrl: ((String? p) {
                        return 'https://image.tmdb.org/t/p/w342${p}';
                      }(widget.posterPath)),
                      width: 130.0,
                      height: 195.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent4,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                        child: Row(
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
                              size: 12.0,
                            ),
                            Text(
                              ((widget.voteAverage ?? 0).toStringAsFixed(1)),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.title,
              maxLines: 2,
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.sora(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
