class Album {
  final String image;

  const Album._(this.image);

  factory Album.fromJson(dynamic json) =>
      Album._(((json['image'] as List).last)['#text']);
}

const albumsData = [
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/ac6921b5afdc64f859a2aa38773a468b.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/cf3a46415a1f4e9cce0f365af8225097.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/1e5ef1165e904436a5a244c936fb505c.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/716e62c7152a4788bb47cfe7207b8521.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/cf47afa9760249238e3269e61b5facb4.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/cdee664c355c4c9dbb0e7ba8db690064.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/05cc536929ca130183b15c1f1f9f221e.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/cc8218235b6f438dbddd294d9022880e.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/667c311baea63b88f110ad49e094fd12.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/c1e96f217c4c4d15a6d00fff66e21226.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/16849a85994fe7b931dd348c5fb70987.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/ba2bc55a13cc4dd9824ef9ebb8f468f0.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/e588abb451e854488dfe2a64a6e0aeb5.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/b788451ab3594c81b77ff24e6f5d439f.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/05442cefecfc46b4aeb6ea62a5366a5e.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/1a77ce6d579b4ba5b0c5caa9a4606cf6.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/bc4e31504f5f47adb31f36aa0889be45.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/742e40bd3aa5e14e86842f457d7ece2c.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/89c670accaa20ceab8f53f5dced75706.jpg'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/6d305843325cec758562218fa504d47e.png'),
  Album._(
      'https:\/\/lastfm.freetls.fastly.net\/i\/u\/174s\/66cf5a401c274f418e0c35268931d6ee.png'),
];
