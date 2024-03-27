class ClothsModel {
  final int? id;
  final String? img;
  final String? category;
  final String? title;
  final String? content;
  final String? price;
  final String? link;

  ClothsModel({
    this.id,
    this.img,
    this.category,
    this.title,
    this.content,
    this.price,
    this.link,
  });

  factory ClothsModel.fromJson(Map<String, dynamic> json) {
    return ClothsModel(
      id: json['id'] == null ? 0 : json['id'] as int,
      img: json['img'] == null ? '' : json['img'] as String,
      category: json['category'] == null ? '' : json['category'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      content: json['content'] == null ? '' : json['content'] as String,
      price: json['price'] == null ? '' : json['price'] as String,
      link: json['link'] == null ? '' : json['link'] as String,
    );
  }
  factory ClothsModel.fromMap(Map<String, dynamic> map) {
    return ClothsModel(
      id: map['id'],
      img: map['img'],
      category: map['category'],
      title: map['title'],
      content: map['content'],
      price: map['price'],
      link: map['link'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img': img,
      'category': category,
      'title': title,
      'content': content,
      'price': price,
      'link': link,
    };
  }
}
