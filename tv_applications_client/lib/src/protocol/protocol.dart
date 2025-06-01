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
import 'media.dart' as _i3;
import 'movie.dart' as _i4;
import 'package:tv_applications_client/src/protocol/movie.dart' as _i5;
import 'package:tv_applications_client/src/protocol/media.dart' as _i6;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i7;
export 'channel_category.dart';
export 'media.dart';
export 'movie.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Type) {
      return _i2.Type.fromJson(data) as T;
    }
    if (t == _i3.Media) {
      return _i3.Media.fromJson(data) as T;
    }
    if (t == _i4.Movie) {
      return _i4.Movie.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Type?>()) {
      return (data != null ? _i2.Type.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Media?>()) {
      return (data != null ? _i3.Media.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Movie?>()) {
      return (data != null ? _i4.Movie.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i4.Movie>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i4.Movie>(e)).toList()
          : null) as T;
    }
    if (t == List<_i5.Movie>) {
      return (data as List).map((e) => deserialize<_i5.Movie>(e)).toList() as T;
    }
    if (t == List<_i6.Media>) {
      return (data as List).map((e) => deserialize<_i6.Media>(e)).toList() as T;
    }
    if (t == List<_i7.UserInfo>) {
      return (data as List).map((e) => deserialize<_i7.UserInfo>(e)).toList()
          as T;
    }
    try {
      return _i7.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Type) {
      return 'Type';
    }
    if (data is _i3.Media) {
      return 'Media';
    }
    if (data is _i4.Movie) {
      return 'Movie';
    }
    className = _i7.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Type') {
      return deserialize<_i2.Type>(data['data']);
    }
    if (dataClassName == 'Media') {
      return deserialize<_i3.Media>(data['data']);
    }
    if (dataClassName == 'Movie') {
      return deserialize<_i4.Movie>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i7.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
