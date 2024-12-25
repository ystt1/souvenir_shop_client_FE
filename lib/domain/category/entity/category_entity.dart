class CategoryEntity {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<dynamic> products;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.products,
  });

}