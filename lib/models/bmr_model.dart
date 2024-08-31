// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BMRModel {
  final String id;
  final String? userId;
  final num? total;
  BMRModel({
    required this.id,
    this.userId,
    this.total,
  });


  BMRModel copyWith({
    String? id,
    String? userId,
    num? total,
  }) {
    return BMRModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'total': total,
    };
  }

  factory BMRModel.fromMap(Map<String, dynamic> map) {
    return BMRModel(
      id: map['\$id'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      total: map['total'] != null ? map['total'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BMRModel.fromJson(String source) => BMRModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BMRModel(id: $id, userId: $userId, total: $total)';

  @override
  bool operator ==(covariant BMRModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.total == total;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ total.hashCode;
}
