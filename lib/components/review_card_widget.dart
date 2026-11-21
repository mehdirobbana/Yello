import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/review_actions_sheet_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'review_card_model.dart';
export 'review_card_model.dart';

/// One Yello review: avatar, name, half-star rating, date, and comment with
/// spoiler protection.
class ReviewCardWidget extends StatefulWidget {
  const ReviewCardWidget({
    super.key,
    String? userName,
    String? userPhotoUrl,
    double? rating,
    String? comment,
    bool? containsSpoilers,
    this.createdAt,
    this.updatedAt,
    bool? isMine,
    String? userId,
    String? reviewId,
    int? movieId,
    String? mediaType,
    bool? opensTitle,
    bool? showMenu,
    this.onEdit,
    this.onDelete,
  })  : this.userName = userName ?? '',
        this.userPhotoUrl = userPhotoUrl ?? '',
        this.rating = rating ?? 0.0,
        this.comment = comment ?? '',
        this.containsSpoilers = containsSpoilers ?? false,
        this.isMine = isMine ?? false,
        this.userId = userId ?? '',
        this.reviewId = reviewId ?? '',
        this.movieId = movieId ?? 0,
        this.mediaType = mediaType ?? '',
        this.opensTitle = opensTitle ?? false,
        this.showMenu = showMenu ?? false;

  final String userName;
  final String userPhotoUrl;
  final double rating;
  final String comment;
  final bool containsSpoilers;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isMine;

  /// Edit DSL param userId
  final String userId;

  /// Edit DSL param reviewId
  final String reviewId;

  /// Edit DSL param movieId
  final int movieId;

  /// Edit DSL param mediaType
  final String mediaType;

  /// Edit DSL param opensTitle
  final bool opensTitle;

  /// Edit DSL param showMenu
  final bool showMenu;

  /// Edit DSL param onEdit
  final Future Function()? onEdit;

  /// Edit DSL param onDelete
  final Future Function()? onDelete;

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget> {
  late ReviewCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewCardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.likesOnInit = await queryReviewLikesRecordOnce(
        queryBuilder: (reviewLikesRecord) => reviewLikesRecord.where(
          'reviewId',
          isEqualTo: widget.reviewId,
        ),
      );
      _model.likes = _model.likesOnInit!.toList().cast<ReviewLikesRecord>();
      safeSetState(() {});
      _model.myLikesOnInit = await queryReviewLikesRecordOnce(
        queryBuilder: (reviewLikesRecord) => reviewLikesRecord
            .where(
              'userId',
              isEqualTo: currentUserUid,
            )
            .where(
              'reviewId',
              isEqualTo: widget.reviewId,
            ),
      );
      _model.myLikes = _model.myLikesOnInit!.toList().cast<ReviewLikesRecord>();
      safeSetState(() {});
      _model.authorDoc = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: widget.userId,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.authorName = (String? v) {
        return v ?? '';
      }(_model.authorDoc?.displayName);
      safeSetState(() {});
      _model.authorPhoto = (String? v) {
        return v ?? '';
      }(_model.authorDoc?.photoUrl);
      safeSetState(() {});
      _model.authorUsername = (String? v) {
        return v ?? '';
      }(_model.authorDoc?.username);
      safeSetState(() {});
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
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (((widget.opensTitle ?? false) && (widget.movieId ?? 0) > 0)) {
          context.pushNamed(
            MovieDetailsPageWidget.routeName,
            queryParameters: {
              'movieId': serializeParam(
                widget.movieId,
                ParamType.int,
              ),
              'mediaType': serializeParam(
                widget.mediaType,
                ParamType.String,
              ),
            }.withoutNulls,
          );
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        PublicProfilePageWidget.routeName,
                        queryParameters: {
                          'userId': serializeParam(
                            widget.userId,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 250),
                          ),
                        },
                      );
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              fadeOutDuration: Duration(milliseconds: 500),
                              imageUrl: ((String? a, String? p) {
                                return (a ?? '').trim().isNotEmpty
                                    ? a!
                                    : ((p ?? '').trim().isNotEmpty
                                        ? p!
                                        : 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix');
                              }(_model.authorPhoto, widget.userPhotoUrl)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.start).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.center).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    PublicProfilePageWidget.routeName,
                                    queryParameters: {
                                      'userId': serializeParam(
                                        widget.userId,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 250),
                                      ),
                                    },
                                  );
                                },
                                child: Text(
                                  ((String? a, String? n) {
                                    return (a ?? '').trim().isNotEmpty
                                        ? a!.trim()
                                        : ((n ?? '').trim().isEmpty
                                            ? 'Yello user'
                                            : n!.trim());
                                  }(_model.authorName, widget.userName)),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.sora(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (widget.isMine)
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 4.0, 8.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '5p5rcal0' /* YOU */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                        if (((String? u) {
                              return (u ?? '').isNotEmpty;
                            }(_model.authorUsername)) ??
                            true)
                          Text(
                            ((String? u) {
                              return '@' + (u ?? '');
                            }(_model.authorUsername)),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
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
                        Text(
                          ((DateTime? c, DateTime? u) {
                            return (u ?? c) == null
                                ? ''
                                : DateFormat.yMMMd().format((u ?? c)!) +
                                    ((u != null &&
                                            c != null &&
                                            u.difference(c).inMinutes > 1)
                                        ? ' · edited'
                                        : '');
                          }(widget.createdAt, widget.updatedAt)),
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment: (FFCrossAxisAlignment.end).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                        direction: Axis.horizontal,
                        rating: widget.rating,
                        unratedColor: FlutterFlowTheme.of(context).accent2,
                        itemCount: 5,
                        itemSize: 15.0,
                      ),
                      Text(
                        ((widget.rating ?? 0).toStringAsFixed(1)),
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
                                  color: FlutterFlowTheme.of(context).secondary,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                  AlignedTooltip(
                    content: Text(
                      FFLocalizations.of(context).getText(
                        'ttmore01' /* More */,
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                    ),
                    preferredDirection: AxisDirection.down,
                    borderRadius: BorderRadius.circular(8.0),
                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                    elevation: 0.0,
                    tailBaseWidth: 0.0,
                    tailLength: 0.0,
                    waitDuration: Duration(milliseconds: 0),
                    showDuration: Duration(milliseconds: 0),
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Visibility(
                      visible: ((widget.isMine ?? false) &&
                              (widget.showMenu ?? false)) ??
                          true,
                      child: FlutterFlowIconButton(
                        borderRadius: 24.0,
                        buttonSize: 48.0,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: ReviewActionsSheetWidget(
                                  onEdit: () async {
                                    Navigator.pop(context);
                                    await widget.onEdit?.call();
                                  },
                                  onDelete: () async {
                                    Navigator.pop(context);
                                    await widget.onDelete?.call();
                                  },
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
              if (((String? c, bool? s, bool? r) {
                    return (c ?? '').trim().isNotEmpty &&
                        (!(s ?? false) || (r ?? false));
                  }(widget.comment, widget.containsSpoilers,
                      _model.revealed)) ??
                  true)
                Text(
                  widget.comment,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.5,
                      ),
                ),
              if (((String? c, bool? s, bool? r) {
                    return (c ?? '').trim().isNotEmpty &&
                        (s ?? false) &&
                        !(r ?? false);
                  }(widget.comment, widget.containsSpoilers,
                      _model.revealed)) ??
                  true)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.revealed = true;
                    safeSetState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent3,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).accent3,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Icon(
                            Icons.visibility_off_rounded,
                            color: FlutterFlowTheme.of(context).error,
                            size: 18.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'mk96sd5r' /* Contains spoilers. Tap to reve... */,
                              ),
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
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  if (((_model.myLikes.length ?? 0) > 0) ?? true)
                    FlutterFlowIconButton(
                      buttonSize: 48.0,
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: FlutterFlowTheme.of(context).error,
                        size: 22.0,
                      ),
                      onPressed: () async {
                        if (!_model.likeBusy!) {
                          _model.likeBusy = true;
                          safeSetState(() {});
                          _model.toggleLikeA = await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord
                                    .where(
                                      'userId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'reviewId',
                                      isEqualTo: widget.reviewId,
                                    ),
                          );
                          if (_model.toggleLikeA?.length == 0) {
                            var reviewLikesRecordReference =
                                ReviewLikesRecord.collection.doc();
                            await reviewLikesRecordReference
                                .set(createReviewLikesRecordData(
                              userId: currentUserUid,
                              reviewId: widget.reviewId,
                              createdAt: DateTime.now(),
                            ));
                            _model.document =
                                ReviewLikesRecord.getDocumentFromData(
                                    createReviewLikesRecordData(
                                      userId: currentUserUid,
                                      reviewId: widget.reviewId,
                                      createdAt: DateTime.now(),
                                    ),
                                    reviewLikesRecordReference);
                          } else {
                            for (int loop1Index = 0;
                                loop1Index < _model.toggleLikeA!.length;
                                loop1Index++) {
                              final currentLoop1Item =
                                  _model.toggleLikeA![loop1Index];
                              await currentLoop1Item.reference.delete();
                            }
                          }

                          _model.myLikesAfterA =
                              await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord
                                    .where(
                                      'userId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'reviewId',
                                      isEqualTo: widget.reviewId,
                                    ),
                          );
                          _model.myLikes = _model.myLikesAfterA!
                              .toList()
                              .cast<ReviewLikesRecord>();
                          safeSetState(() {});
                          _model.likesAfterA = await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord.where(
                              'reviewId',
                              isEqualTo: widget.reviewId,
                            ),
                          );
                          _model.likes = _model.likesAfterA!
                              .toList()
                              .cast<ReviewLikesRecord>();
                          safeSetState(() {});
                          _model.likeBusy = false;
                          safeSetState(() {});
                        }

                        safeSetState(() {});
                      },
                    ),
                  if ((_model.myLikes.length == 0) ?? true)
                    FlutterFlowIconButton(
                      buttonSize: 48.0,
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 22.0,
                      ),
                      onPressed: () async {
                        if (!_model.likeBusy!) {
                          _model.likeBusy = true;
                          safeSetState(() {});
                          _model.toggleLikeB = await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord
                                    .where(
                                      'userId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'reviewId',
                                      isEqualTo: widget.reviewId,
                                    ),
                          );
                          if (_model.toggleLikeB?.length == 0) {
                            var reviewLikesRecordReference =
                                ReviewLikesRecord.collection.doc();
                            await reviewLikesRecordReference
                                .set(createReviewLikesRecordData(
                              userId: currentUserUid,
                              reviewId: widget.reviewId,
                              createdAt: DateTime.now(),
                            ));
                            _model.document2 =
                                ReviewLikesRecord.getDocumentFromData(
                                    createReviewLikesRecordData(
                                      userId: currentUserUid,
                                      reviewId: widget.reviewId,
                                      createdAt: DateTime.now(),
                                    ),
                                    reviewLikesRecordReference);
                          } else {
                            for (int loop1Index = 0;
                                loop1Index < _model.toggleLikeB!.length;
                                loop1Index++) {
                              final currentLoop1Item =
                                  _model.toggleLikeB![loop1Index];
                              await currentLoop1Item.reference.delete();
                            }
                          }

                          _model.myLikesAfterB =
                              await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord
                                    .where(
                                      'userId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'reviewId',
                                      isEqualTo: widget.reviewId,
                                    ),
                          );
                          _model.myLikes = _model.myLikesAfterB!
                              .toList()
                              .cast<ReviewLikesRecord>();
                          safeSetState(() {});
                          _model.likesAfterB = await queryReviewLikesRecordOnce(
                            queryBuilder: (reviewLikesRecord) =>
                                reviewLikesRecord.where(
                              'reviewId',
                              isEqualTo: widget.reviewId,
                            ),
                          );
                          _model.likes = _model.likesAfterB!
                              .toList()
                              .cast<ReviewLikesRecord>();
                          safeSetState(() {});
                          _model.likeBusy = false;
                          safeSetState(() {});
                        }

                        safeSetState(() {});
                      },
                    ),
                  Text(
                    (_model.likes.length.toString()),
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(width: 4.0)),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
