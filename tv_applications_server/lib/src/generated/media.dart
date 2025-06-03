/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'channel_category.dart' as _i2;
import 'movie.dart' as _i3;
import 'dart:typed_data' as _i4;

abstract class Media implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Media._({
    this.id,
    required this.title,
    required this.url,
    this.cookie,
    this.userAgent,
    required this.type,
    this.shows,
    this.channelsUrl,
    this.thumbnail,
    required this.thumbnailUrl,
  });

  factory Media({
    int? id,
    required String title,
    required String url,
    String? cookie,
    String? userAgent,
    required _i2.Type type,
    List<_i3.Movie>? shows,
    String? channelsUrl,
    _i4.ByteData? thumbnail,
    required String thumbnailUrl,
  }) = _MediaImpl;

  factory Media.fromJson(Map<String, dynamic> jsonSerialization) {
    return Media(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String,
      cookie: jsonSerialization['cookie'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      type: _i2.Type.fromJson((jsonSerialization['type'] as String)),
      shows: (jsonSerialization['shows'] as List?)
          ?.map((e) => _i3.Movie.fromJson((e as Map<String, dynamic>)))
          .toList(),
      channelsUrl: jsonSerialization['channelsUrl'] as String?,
      thumbnail: jsonSerialization['thumbnail'] == null
          ? null
          : _i1.ByteDataJsonExtension.fromJson(jsonSerialization['thumbnail']),
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String,
    );
  }

  static final t = MediaTable();

  static const db = MediaRepository._();

  @override
  int? id;

  /// The title of the TV entry.
  String title;

  /// The main URL of the TV entry.
  String url;

  String? cookie;

  String? userAgent;

  /// The type of the TV entry (e.g., Shows, Channel, etc.).
  _i2.Type type;

  /// The related movies/shows.
  List<_i3.Movie>? shows;

  /// Optional URL for the channels.
  String? channelsUrl;

  /// The thumbnail image (binary data).
  _i4.ByteData? thumbnail;

  /// The URL of the thumbnail image.
  String thumbnailUrl;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Media]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Media copyWith({
    int? id,
    String? title,
    String? url,
    String? cookie,
    String? userAgent,
    _i2.Type? type,
    List<_i3.Movie>? shows,
    String? channelsUrl,
    _i4.ByteData? thumbnail,
    String? thumbnailUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'url': url,
      if (cookie != null) 'cookie': cookie,
      if (userAgent != null) 'userAgent': userAgent,
      'type': type.toJson(),
      if (shows != null) 'shows': shows?.toJson(valueToJson: (v) => v.toJson()),
      if (channelsUrl != null) 'channelsUrl': channelsUrl,
      if (thumbnail != null) 'thumbnail': thumbnail?.toJson(),
      'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'url': url,
      if (cookie != null) 'cookie': cookie,
      if (userAgent != null) 'userAgent': userAgent,
      'type': type.toJson(),
      if (shows != null)
        'shows': shows?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (channelsUrl != null) 'channelsUrl': channelsUrl,
      if (thumbnail != null) 'thumbnail': thumbnail?.toJson(),
      'thumbnailUrl': thumbnailUrl,
    };
  }

  static MediaInclude include() {
    return MediaInclude._();
  }

  static MediaIncludeList includeList({
    _i1.WhereExpressionBuilder<MediaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaTable>? orderByList,
    MediaInclude? include,
  }) {
    return MediaIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Media.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Media.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MediaImpl extends Media {
  _MediaImpl({
    int? id,
    required String title,
    required String url,
    String? cookie,
    String? userAgent,
    required _i2.Type type,
    List<_i3.Movie>? shows,
    String? channelsUrl,
    _i4.ByteData? thumbnail,
    required String thumbnailUrl,
  }) : super._(
          id: id,
          title: title,
          url: url,
          cookie: cookie,
          userAgent: userAgent,
          type: type,
          shows: shows,
          channelsUrl: channelsUrl,
          thumbnail: thumbnail,
          thumbnailUrl: thumbnailUrl,
        );

  /// Returns a shallow copy of this [Media]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Media copyWith({
    Object? id = _Undefined,
    String? title,
    String? url,
    Object? cookie = _Undefined,
    Object? userAgent = _Undefined,
    _i2.Type? type,
    Object? shows = _Undefined,
    Object? channelsUrl = _Undefined,
    Object? thumbnail = _Undefined,
    String? thumbnailUrl,
  }) {
    return Media(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      cookie: cookie is String? ? cookie : this.cookie,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      type: type ?? this.type,
      shows: shows is List<_i3.Movie>?
          ? shows
          : this.shows?.map((e0) => e0.copyWith()).toList(),
      channelsUrl: channelsUrl is String? ? channelsUrl : this.channelsUrl,
      thumbnail:
          thumbnail is _i4.ByteData? ? thumbnail : this.thumbnail?.clone(),
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}

class MediaTable extends _i1.Table<int?> {
  MediaTable({super.tableRelation}) : super(tableName: 'media') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    cookie = _i1.ColumnString(
      'cookie',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    shows = _i1.ColumnSerializable(
      'shows',
      this,
    );
    channelsUrl = _i1.ColumnString(
      'channelsUrl',
      this,
    );
    thumbnail = _i1.ColumnByteData(
      'thumbnail',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
  }

  /// The title of the TV entry.
  late final _i1.ColumnString title;

  /// The main URL of the TV entry.
  late final _i1.ColumnString url;

  late final _i1.ColumnString cookie;

  late final _i1.ColumnString userAgent;

  /// The type of the TV entry (e.g., Shows, Channel, etc.).
  late final _i1.ColumnEnum<_i2.Type> type;

  /// The related movies/shows.
  late final _i1.ColumnSerializable shows;

  /// Optional URL for the channels.
  late final _i1.ColumnString channelsUrl;

  /// The thumbnail image (binary data).
  late final _i1.ColumnByteData thumbnail;

  /// The URL of the thumbnail image.
  late final _i1.ColumnString thumbnailUrl;

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        url,
        cookie,
        userAgent,
        type,
        shows,
        channelsUrl,
        thumbnail,
        thumbnailUrl,
      ];
}

class MediaInclude extends _i1.IncludeObject {
  MediaInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Media.t;
}

class MediaIncludeList extends _i1.IncludeList {
  MediaIncludeList._({
    _i1.WhereExpressionBuilder<MediaTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Media.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Media.t;
}

class MediaRepository {
  const MediaRepository._();

  /// Returns a list of [Media]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Media>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Media>(
      where: where?.call(Media.t),
      orderBy: orderBy?.call(Media.t),
      orderByList: orderByList?.call(Media.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Media] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Media?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaTable>? where,
    int? offset,
    _i1.OrderByBuilder<MediaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Media>(
      where: where?.call(Media.t),
      orderBy: orderBy?.call(Media.t),
      orderByList: orderByList?.call(Media.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Media] by its [id] or null if no such row exists.
  Future<Media?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Media>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Media]s in the list and returns the inserted rows.
  ///
  /// The returned [Media]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Media>> insert(
    _i1.Session session,
    List<Media> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Media>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Media] and returns the inserted row.
  ///
  /// The returned [Media] will have its `id` field set.
  Future<Media> insertRow(
    _i1.Session session,
    Media row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Media>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Media]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Media>> update(
    _i1.Session session,
    List<Media> rows, {
    _i1.ColumnSelections<MediaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Media>(
      rows,
      columns: columns?.call(Media.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Media]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Media> updateRow(
    _i1.Session session,
    Media row, {
    _i1.ColumnSelections<MediaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Media>(
      row,
      columns: columns?.call(Media.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Media]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Media>> delete(
    _i1.Session session,
    List<Media> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Media>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Media].
  Future<Media> deleteRow(
    _i1.Session session,
    Media row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Media>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Media>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MediaTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Media>(
      where: where(Media.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Media>(
      where: where?.call(Media.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
