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

abstract class Tv implements _i1.SerializableModel {
  Tv._({
    this.id,
    required this.title,
    required this.url,
    required this.type,
    this.shows,
    this.channelsUrl,
    this.thumbnail,
    required this.thumbnailUrl,
  });

  factory Tv({
    int? id,
    required String title,
    required String url,
    required _i2.Type type,
    List<_i3.Movie>? shows,
    String? channelsUrl,
    _i4.ByteData? thumbnail,
    required String thumbnailUrl,
  }) = _TvImpl;

  factory Tv.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tv(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String,
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

  /// Returns a shallow copy of this [Tv]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tv copyWith({
    int? id,
    String? title,
    String? url,
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

class _TvImpl extends Tv {
  _TvImpl({
    int? id,
    required String title,
    required String url,
    required _i2.Type type,
    List<_i3.Movie>? shows,
    String? channelsUrl,
    _i4.ByteData? thumbnail,
    required String thumbnailUrl,
  }) : super._(
          id: id,
          title: title,
          url: url,
          type: type,
          shows: shows,
          channelsUrl: channelsUrl,
          thumbnail: thumbnail,
          thumbnailUrl: thumbnailUrl,
        );

  /// Returns a shallow copy of this [Tv]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tv copyWith({
    Object? id = _Undefined,
    String? title,
    String? url,
    _i2.Type? type,
    Object? shows = _Undefined,
    Object? channelsUrl = _Undefined,
    Object? thumbnail = _Undefined,
    String? thumbnailUrl,
  }) {
    return Tv(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      url: url ?? this.url,
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
