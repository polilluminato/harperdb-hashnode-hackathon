class Post {
  final int id;
  final String link;
  final String platform;
  final DateTime postDate;
  final String text;
  final String title;

  Post({
    required this.id,
    required this.link,
    required this.platform,
    required this.postDate,
    required this.text,
    required this.title,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      id: int.parse(json['id']),
      link: json['link'] as String,
      platform: json['platform'] as String,
      postDate: DateTime.parse(json['post_date']),
      text: json['text'] as String,
      title: json['title'] as String,
    );
  }
}
