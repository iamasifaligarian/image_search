// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashResponse _$UnsplashResponseFromJson(Map<String, dynamic> json) {
  return UnsplashResponse(
    (json['results'] as List<dynamic>?)
        ?.map((e) => UnsplashResults.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UnsplashResponseToJson(UnsplashResponse instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

UnsplashResults _$UnsplashResultsFromJson(Map<String, dynamic> json) {
  return UnsplashResults(
    json['description'] as String?,
    json['urls'] == null
        ? null
        : Urls.fromJson(json['urls'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UnsplashResultsToJson(UnsplashResults instance) =>
    <String, dynamic>{
      'description': instance.description,
      'urls': instance.urls?.toJson(),
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    json['raw'] as String,
    json['full'] as String,
    json['regular'] as String,
    json['small'] as String,
    json['thumb'] as String,
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };
