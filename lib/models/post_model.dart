class Post {
  String id;
  String link;
  String platform;
  DateTime postDate;
  String text;
  String title;

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
      id: json['id'] as String,
      link: json['link'] as String,
      platform: json['platform'] as String,
      postDate: DateTime.parse(json['post_date']),
      text: json['text'] as String,
      title: json['title'] as String,
    );
  }
}
