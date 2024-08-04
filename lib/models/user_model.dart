import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String nama;
  final String email;
  final String status;
  final int umur;
  final int tinggi;
  final int berat;
  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.status,
    required this.umur,
    required this.tinggi,
    required this.berat,
  });

  UserModel copyWith({
    String? id,
    String? nama,
    String? email,
    String? status,
    int? umur,
    int? tinggi,
    int? berat,
  }) {
    return UserModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      status: status ?? this.status,
      umur: umur ?? this.umur,
      tinggi: tinggi ?? this.tinggi,
      berat: berat ?? this.berat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'email': email,
      'status': status,
      'umur': umur,
      'tinggi': tinggi,
      'berat': berat,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      status: map['status'] ?? '',
      umur: map['umur'] ?? 0,
      tinggi: map['tinggi'] ?? 0,
      berat: map['berat'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, nama: $nama, email: $email, status: $status, umur: $umur, tinggi: $tinggi, berat: $berat)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama == nama &&
        other.email == email &&
        other.status == status &&
        other.umur == umur &&
        other.tinggi == tinggi &&
        other.berat == berat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nama.hashCode ^
        email.hashCode ^
        status.hashCode ^
        umur.hashCode ^
        tinggi.hashCode ^
        berat.hashCode;
  }
}
