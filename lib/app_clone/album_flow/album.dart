class Album {
  final String image;

  Album._(this.image);

  factory Album.fromJson(dynamic json) =>
      Album._(((json['image'] as List).last)['#text']);
}
