class Recipe {
  final String name;
  final String linkUrl;
  final String images;
  final double rating;
  final String totalTime;

  Recipe({required this.name,required this.linkUrl, required this.images, required this.rating, required this.totalTime});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        name: json['name'] as String,
        linkUrl: json['link'] as String,
        images: json['images'] as String,
        rating: json['rating'] as double,
        totalTime: json['total_time'] as String);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Recipe {name: $name, link: $linkUrl, image: $images, rating: $rating, totalTime: $totalTime}';
  }
}