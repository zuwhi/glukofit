// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdukModel {
  final String id;
  final String nama_produk;
  final String image;
  final String? desc;

  ProdukModel({
    required this.id,
    required this.nama_produk,
    required this.image,
    this.desc,
  });

  ProdukModel copyWith({
    String? id,
    String? nama_produk,
    String? image,
    String? desc,
  }) {
    return ProdukModel(
      id: id ?? this.id,
      nama_produk: nama_produk ?? this.nama_produk,
      image: image ?? this.image,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama_produk': nama_produk,
      'image': image,
      'desc': desc,
    };
  }

  factory ProdukModel.fromMap(Map<String, dynamic> map) {
    return ProdukModel(
      id: map['\$id'] as String,
      nama_produk: map['nama_produk'] as String,
      image: map['image'] as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdukModel.fromJson(String source) =>
      ProdukModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProdukModel(id: $id, nama_produk: $nama_produk, image: $image, desc: $desc)';
  }

  @override
  bool operator ==(covariant ProdukModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama_produk == nama_produk &&
        other.image == image &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nama_produk.hashCode ^ image.hashCode ^ desc.hashCode;
  }
}
