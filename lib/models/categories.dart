import 'dart:convert';

class Category {
  int id;
  String name;
  String description;
  int parent;
  Image image;
  int count;
  Category({
    this.id,
    this.name,
    this.description,
    this.parent,
    this.image,
    this.count,
  });

  Category copyWith({
    int id,
    String name,
    String description,
    int parent,
    Image image,
    int count,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parent: parent ?? this.parent,
      image: image ?? this.image,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'parent': parent,
      'image': image?.toMap(),
      'count': count,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      parent: map['parent'],
      image: Image.fromMap(map['image']),
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, parent: $parent, image: $image, count: $count)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Category &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.parent == parent &&
        o.image == image &&
        o.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        parent.hashCode ^
        image.hashCode ^
        count.hashCode;
  }
}

class Image {
  String url;
  Image({
    this.url,
  });

  Image copyWith({
    String url,
  }) {
    return Image(
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'src': url,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Image(
      url: map['src'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));
}
