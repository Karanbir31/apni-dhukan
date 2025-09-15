class Category {
  String slug;
  String name;
  String url;
  String? imageUrl;

  Category({
    this.slug = "slug",
    this.name = "name",
    this.url = "url",
    this.imageUrl = ""
  });

  // to json
  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  // from json
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      imageUrl: null
    );
  }

  // ✅ function to update imageUrl
  void setImageUrl(String url) {
    imageUrl = url;
  }


}
