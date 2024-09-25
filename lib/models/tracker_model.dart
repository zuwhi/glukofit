// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrackerModel {
  final String id;
  final String? userId;
  final String? keterangan;
  final String? jam;
  final String? tanggal;
  final int? kalori;
  final num? gula;
  TrackerModel({
    required this.id,
    this.userId,
    this.keterangan,
    this.jam,
    this.tanggal,
    this.kalori,
    this.gula,
  });

  TrackerModel copyWith({
    String? id,
    String? userId,
    String? keterangan,
    String? jam,
    String? tanggal,
    int? kalori,
    num? gula,
  }) {
    return TrackerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      keterangan: keterangan ?? this.keterangan,
      jam: jam ?? this.jam,
      tanggal: tanggal ?? this.tanggal,
      kalori: kalori ?? this.kalori,
      gula: gula ?? this.gula,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'keterangan': keterangan,
      'jam': jam,
      'tanggal': tanggal,
      'kalori': kalori,
      'gula': gula,
    };
  }

  factory TrackerModel.fromMap(Map<String, dynamic> map) {
    return TrackerModel(
      id: map['\$id'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      keterangan:
          map['keterangan'] != null ? map['keterangan'] as String : null,
      jam: map['jam'] != null ? map['jam'] as String : null,
      tanggal: map['tanggal'] != null ? map['tanggal'] as String : null,
      kalori: map['kalori'] != null ? map['kalori'] as int : null,
      gula: map['gula'] != null ? map['gula'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackerModel.fromJson(String source) =>
      TrackerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrackerModel(id: $id, userId: $userId, keterangan: $keterangan, jam: $jam, tanggal: $tanggal, kalori: $kalori, gula: $gula)';
  }

  @override
  bool operator ==(covariant TrackerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.keterangan == keterangan &&
        other.jam == jam &&
        other.tanggal == tanggal &&
        other.kalori == kalori &&
        other.gula == gula;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        keterangan.hashCode ^
        jam.hashCode ^
        tanggal.hashCode ^
        kalori.hashCode ^
        gula.hashCode;
  }
}
