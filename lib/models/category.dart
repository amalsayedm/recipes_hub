class Category {
  final String name;
  final int catId;

  Category({required this.name,required this.catId});

  factory Category.fromJson(dynamic json) {
    return Category(
        name: json['name'] as String,
        catId: json['id'] as int,
        );
  }

  static List<Category> CategoryFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Category.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Category {name: $name, id: $catId}';
  }
}