class Meme {
  final String postLink;
  final String subreddit;
  final String title;
  final String url;
  final bool nsfw;
  final bool spoiler;
  final String author;
  final int ups;
  final List<String> preview;

// Great question!
// Yes, inside the factory Meme.fromJson constructor, a new Meme object is created using the regular constructor:

// Here, the factory constructor parses the JSON and then calls the default constructor to create and return a new Meme instance.
// So, the object is created inside the factory constructor using the class’s regular constructor.


  Meme({
    required this.postLink,
    required this.subreddit,
    required this.title,
    required this.url,
    required this.nsfw,
    required this.spoiler,
    required this.author,
    required this.ups,
    required this.preview,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      postLink: json['postLink'] as String,
      subreddit: json['subreddit'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      nsfw: json['nsfw'] as bool,
      spoiler: json['spoiler'] as bool,
      author: json['author'] as String,
      ups: json['ups'] as int,
      preview: List<String>.from(json['preview'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postLink': postLink,
      'subreddit': subreddit,
      'title': title,
      'url': url,
      'nsfw': nsfw,
      'spoiler': spoiler,
      'author': author,
      'ups': ups,
      'preview': preview,
    };
  }
}
