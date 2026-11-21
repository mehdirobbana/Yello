import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/review_card_widget.dart';
import '/components/username_tag_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'public_profile_page_model.dart';
export 'public_profile_page_model.dart';

/// Public profile: name, follow state, follower counts, reviews and
/// favorites.
class PublicProfilePageWidget extends StatefulWidget {
  const PublicProfilePageWidget({
    super.key,
    String? userId,
  }) : this.userId = userId ?? '';

  final String userId;

  static String routeName = 'PublicProfilePage';
  static String routePath = '/user';

  @override
  State<PublicProfilePageWidget> createState() =>
      _PublicProfilePageWidgetState();
}

class _PublicProfilePageWidgetState extends State<PublicProfilePageWidget> {
  late PublicProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PublicProfilePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.profileUser = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: widget.userId,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.profileName = _model.profileUser?.displayName;
      safeSetState(() {});
      _model.profilePhoto = _model.profileUser?.photoUrl;
      safeSetState(() {});
      _model.mineOnLoad = await queryFollowsRecordOnce(
        queryBuilder: (followsRecord) => followsRecord
            .where(
              'followerId',
              isEqualTo: currentUserUid,
            )
            .where(
              'followingId',
              isEqualTo: widget.userId,
            ),
      );
      _model.myFollows = _model.mineOnLoad!.toList().cast<FollowsRecord>();
      safeSetState(() {});
      _model.followersOnLoad = await queryFollowsRecordOnce(
        queryBuilder: (followsRecord) => followsRecord.where(
          'followingId',
          isEqualTo: widget.userId,
        ),
      );
      _model.followers = _model.followersOnLoad!.toList().cast<FollowsRecord>();
      safeSetState(() {});
      _model.followingOnLoad = await queryFollowsRecordOnce(
        queryBuilder: (followsRecord) => followsRecord.where(
          'followerId',
          isEqualTo: widget.userId,
        ),
      );
      _model.following = _model.followingOnLoad!.toList().cast<FollowsRecord>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.spaceBetween).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AlignedTooltip(
                        content: Text(
                          FFLocalizations.of(context).getText(
                            'pj2x8m51' /* Back */,
                          ),
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
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryText,
                        elevation: 0.0,
                        tailBaseWidth: 0.0,
                        tailLength: 0.0,
                        waitDuration: Duration(milliseconds: 0),
                        showDuration: Duration(milliseconds: 0),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: FlutterFlowIconButton(
                          borderRadius: 24.0,
                          buttonSize: 48.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.safePop();
                          },
                        ),
                      ),
                      Builder(
                        builder: (context) => FlutterFlowIconButton(
                          borderRadius: 16.0,
                          buttonSize: 48.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.ios_share_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 22.0,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                                text: ((String? n, String? u) {
                              return 'Check out ' +
                                  ((n ?? '').trim().isEmpty
                                      ? 'this profile'
                                      : n!.trim()) +
                                  ' on Yello: ' +
                                  'https://movies-fglaj1.flutterflow.app/user?userId=' +
                                  (u ?? '');
                            }(_model.profileName, widget.userId))));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Profile link copied',
                                  style: TextStyle(),
                                ),
                                duration: Duration(milliseconds: 4000),
                              ),
                            );
                            await Share.share(
                              ((String? n, String? u) {
                                return 'Check out ' +
                                    ((n ?? '').trim().isEmpty
                                        ? 'this profile'
                                        : n!.trim()) +
                                    ' on Yello: ' +
                                    'https://movies-fglaj1.flutterflow.app/user?userId=' +
                                    (u ?? '');
                              }(_model.profileName, widget.userId)),
                              sharePositionOrigin:
                                  getWidgetBoundingBox(context),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 96.0,
                    height: 96.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeOutDuration: Duration(milliseconds: 500),
                      imageUrl: ((String? p) {
                        return (p ?? '').trim().isEmpty
                            ? 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix'
                            : (p ?? '');
                      }(_model.profilePhoto)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    _model.profileName!,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                  wrapWithModel(
                    model: _model.publicProfileUsernameModel,
                    updateCallback: () => safeSetState(() {}),
                    child: UsernameTagWidget(
                      userId: widget.userId,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            (_model.followers.length.toString()),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.sora(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              't46mlc0g' /* Followers */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            (_model.following.length.toString()),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.sora(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'mv4w4kyc' /* Following */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(width: 32.0)),
                  ),
                  if (!(currentUserUid == widget.userId))
                    FFButtonWidget(
                      onPressed: _model.followBusy!
                          ? null
                          : () async {
                              _model.followBusy = true;
                              safeSetState(() {});
                              _model.toggleMine = await queryFollowsRecordOnce(
                                queryBuilder: (followsRecord) => followsRecord
                                    .where(
                                      'followerId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'followingId',
                                      isEqualTo: widget.userId,
                                    ),
                              );
                              if (_model.toggleMine?.length == 0) {
                                var followsRecordReference =
                                    FollowsRecord.collection.doc();
                                await followsRecordReference
                                    .set(createFollowsRecordData(
                                  followerId: currentUserUid,
                                  followingId: widget.userId,
                                  createdAt: DateTime.now(),
                                ));
                                _model.document =
                                    FollowsRecord.getDocumentFromData(
                                        createFollowsRecordData(
                                          followerId: currentUserUid,
                                          followingId: widget.userId,
                                          createdAt: DateTime.now(),
                                        ),
                                        followsRecordReference);
                              } else {
                                for (int loop1Index = 0;
                                    loop1Index < _model.toggleMine!.length;
                                    loop1Index++) {
                                  final currentLoop1Item =
                                      _model.toggleMine![loop1Index];
                                  await currentLoop1Item.reference.delete();
                                }
                              }

                              _model.mineAfter = await queryFollowsRecordOnce(
                                queryBuilder: (followsRecord) => followsRecord
                                    .where(
                                      'followerId',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'followingId',
                                      isEqualTo: widget.userId,
                                    ),
                              );
                              _model.myFollows = _model.mineAfter!
                                  .toList()
                                  .cast<FollowsRecord>();
                              safeSetState(() {});
                              _model.followersAfter =
                                  await queryFollowsRecordOnce(
                                queryBuilder: (followsRecord) =>
                                    followsRecord.where(
                                  'followingId',
                                  isEqualTo: widget.userId,
                                ),
                              );
                              _model.followers = _model.followersAfter!
                                  .toList()
                                  .cast<FollowsRecord>();
                              safeSetState(() {});
                              _model.followBusy = false;
                              safeSetState(() {});

                              safeSetState(() {});
                            },
                      text: ((int? n) {
                        return (n ?? 0) > 0 ? 'Remove friend' : 'Add friend';
                      }(_model.myFollows.length)),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: TextStyle(
                          color: FlutterFlowTheme.of(context).tertiary,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  Text(
                    FFLocalizations.of(context).getText(
                      't1exikx0' /* Reviews */,
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  StreamBuilder<List<ReviewsRecord>>(
                    stream: queryReviewsRecord(
                      queryBuilder: (reviewsRecord) => reviewsRecord
                          .where(
                            'userId',
                            isEqualTo: widget.userId,
                          )
                          .orderBy('createdAt', descending: true),
                      limit: 50,
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
                      List<ReviewsRecord> columnReviewsRecordList =
                          snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final listItem = columnReviewsRecordList.toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children:
                                List.generate(listItem.length, (listItemIndex) {
                              final listItemItem = listItem[listItemIndex];
                              return wrapWithModel(
                                model: _model.reviewCardModels.getModel(
                                  listItemIndex.toString(),
                                  listItemIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: ReviewCardWidget(
                                  key: Key(
                                    'Key5br_${listItemIndex.toString()}',
                                  ),
                                  comment: listItemItem.comment,
                                  containsSpoilers:
                                      listItemItem.containsSpoilers,
                                  createdAt: listItemItem.createdAt,
                                  isMine: listItemItem.userId == currentUserUid,
                                  rating: listItemItem.rating,
                                  updatedAt: listItemItem.updatedAt,
                                  userName: listItemItem.userName,
                                  userPhotoUrl: listItemItem.userPhotoUrl,
                                  userId: listItemItem.userId,
                                  reviewId: (String? u, String? m) {
                                    return '${u}_${m}';
                                  }(listItemItem.userId, listItemItem.mediaKey),
                                  movieId: listItemItem.tmdbId,
                                  mediaType: listItemItem.mediaType,
                                  opensTitle: true,
                                  onEdit: () async {},
                                  onDelete: () async {},
                                ),
                              );
                            }),
                          );
                        },
                      );
                    },
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '8vmq7uyf' /* Favorites */,
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  StreamBuilder<List<FavoritesRecord>>(
                    stream: queryFavoritesRecord(
                      queryBuilder: (favoritesRecord) => favoritesRecord
                          .where(
                            'userId',
                            isEqualTo: widget.userId,
                          )
                          .orderBy('createdAt', descending: true),
                      limit: 50,
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
                      List<FavoritesRecord> columnFavoritesRecordList =
                          snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final listItem = columnFavoritesRecordList.toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children:
                                List.generate(listItem.length, (listItemIndex) {
                              final listItemItem = listItem[listItemIndex];
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
                                        listItemItem.tmdbId,
                                        ParamType.int,
                                      ),
                                      'mediaType': serializeParam(
                                        listItemItem.mediaType,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 500),
                                            fadeOutDuration:
                                                Duration(milliseconds: 500),
                                            imageUrl: ((String? p) {
                                              return 'https://image.tmdb.org/t/p/w185${p}';
                                            }(listItemItem.posterPath)),
                                            width: 60.0,
                                            height: 90.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          listItemItem.title,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.sora(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                  ),
                                ),
                              );
                            }).divide(SizedBox(height: 8.0)),
                          );
                        },
                      );
                    },
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
