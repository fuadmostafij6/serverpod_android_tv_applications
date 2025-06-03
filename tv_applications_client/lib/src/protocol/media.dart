/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'channel_category.dart' as _i2;
import 'movie.dart' as _i3;
import 'dart:typed_data' as _i4;

abstract class Media implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
