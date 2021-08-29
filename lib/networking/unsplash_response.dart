import 'package:json_annotation/json_annotation.dart';

part 'unsplash_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UnsplashResponse {
  late List<UnsplashResults>? results;

  UnsplashResponse(this.results);

  factory UnsplashResponse.fromJson(Map<String, dynamic> json) =>
      _$UnsplashResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnsplashResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UnsplashResults {
  late String? description;
  late Urls? urls;

  UnsplashResults(this.description, this.urls);

  factory UnsplashResults.fromJson(Map<String, dynamic> json) =>
      _$UnsplashResultsFromJson(json);

  Map<String, dynamic> toJson() => _$UnsplashResultsToJson(this);
}

@JsonSerializable()
class Urls {
  late String raw;
  late String full;
  late String regular;
  late String small;
  late String thumb;

  Urls(this.raw, this.full, this.regular, this.small, this.thumb);

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
