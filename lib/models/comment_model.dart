// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  String id;
  String artikelId;
  String userId;
  String content;
  String createdAt;
  CommentModel({
    required this.id,
    required this.artikelId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  CommentModel copyWith({
    String? id,
    String? artikelId,
    String? userId,
    String? content,
    String? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      artikelId: artikelId ?? this.artikelId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artikelId': artikelId,
      'userId': userId,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['\$id'] ?? '',
      artikelId: map['artikelId'] ?? '',
      userId: map['userId'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(id: $id, artikelId: $artikelId, userId: $userId, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.artikelId == artikelId &&
        other.userId == userId &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        artikelId.hashCode ^
        userId.hashCode ^
        content.hashCode ^
        createdAt.hashCode;
  }
}
