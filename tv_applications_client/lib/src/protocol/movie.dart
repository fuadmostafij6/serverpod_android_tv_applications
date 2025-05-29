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
import 'dart:typed_data' as _i2;

abstract class Movie implements _i1.SerializableModel {
  Movie._({
    this.id,
    this.title,
    this.url,
    this.thumbnail,
    this.thumbnailUrl,
  });

  factory Movie({
    int? id,
    String? title,
    String? url,
    _i2.ByteData? thumbnail,
    String? thumbnailUrl,
  }) = _MovieImpl;

  factory Movie.fromJson(Map<String, dynamic> jsonSerialization) {
    return Movie(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String?,
      url: jsonSerialization['url'] as String?,
      thumbnail: jsonSerialization['thumbnail'] == null
          ? null
          : _i1.ByteDataJsonExtension.fromJson(jsonSerialization['thumbnail']),
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The title of the movie.
  String? title;

  /// The URL of the movie.
  String? url;

  /// The thumbnail as binary data.
  _i2.ByteData? thumbnail;

  /// The URL of the thumbnail.
  String? thumbnailUrl;

  /// Returns a shallow copy of this [Movie]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Movie copyWith({
    int? id,
    String? title,
    String? url,
    _i2.ByteData? thumbnail,
    String? thumbnailUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (thumbnail != null) 'thumbnail': thumbnail?.toJson(),
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MovieImpl extends Movie {
  _MovieImpl({
    int? id,
    String? title,
    String? url,
    _i2.ByteData? thumbnail,
    String? thumbnailUrl,
  }) : super._(
          id: id,
          title: title,
          url: url,
          thumbnail: thumbnail,
          thumbnailUrl: thumbnailUrl,
        );

  /// Returns a shallow copy of this [Movie]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Movie copyWith({
    Object? id = _Undefined,
    Object? title = _Undefined,
    Object? url = _Undefined,
    Object? thumbnail = _Undefined,
    Object? thumbnailUrl = _Undefined,
  }) {
    return Movie(
      id: id is int? ? id : this.id,
      title: title is String? ? title : this.title,
      url: url is String? ? url : this.url,
      thumbnail:
          thumbnail is _i2.ByteData? ? thumbnail : this.thumbnail?.clone(),
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
    );
  }
}
