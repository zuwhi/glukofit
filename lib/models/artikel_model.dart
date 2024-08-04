import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArtikelModel {
final String id;
final String tanggal;
final String imageId;
final String kategori;
final String judul;
final String deskripsi;
  ArtikelModel({
    required this.id,
    required this.tanggal,
    required this.imageId,
    required this.kategori,
    required this.judul,
    required this.deskripsi,
  });

  ArtikelModel copyWith({
    String? id,
    String? tanggal,
    String? imageId,
    String? kategori,
    String? judul,
    String? deskripsi,
  }) {
    return ArtikelModel(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      imageId: imageId ?? this.imageId,
      kategori: kategori ?? this.kategori,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tanggal': tanggal,
      'imageId': imageId,
      'kategori': kategori,
      'judul': judul,
      'deskripsi': deskripsi,
    };
  }

  factory ArtikelModel.fromMap(Map<String, dynamic> map) {
    return ArtikelModel(
      id: map['\$id'] ?? '',
      tanggal: map['tanggal'] ?? '',
      imageId: map['imageId'] ?? '',
      kategori: map['kategori'] ?? '',
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtikelModel.fromJson(String source) => ArtikelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArtikelModel(id: $id, tanggal: $tanggal, imageId: $imageId, kategori: $kategori, judul: $judul, deskripsi: $deskripsi)';
  }

  @override
  bool operator ==(covariant ArtikelModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.tanggal == tanggal &&
      other.imageId == imageId &&
      other.kategori == kategori &&
      other.judul == judul &&
      other.deskripsi == deskripsi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tanggal.hashCode ^
      imageId.hashCode ^
      kategori.hashCode ^
      judul.hashCode ^
      deskripsi.hashCode;
  }
}
