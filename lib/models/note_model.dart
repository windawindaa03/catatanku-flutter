import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Enumerasi Kategori Catatan
enum NoteCategory {
  kuliah,
  tugas,
  ide,
  pribadi,
  organisasi;

  String get label {
    switch (this) {
      case NoteCategory.kuliah:
        return 'Kuliah';
      case NoteCategory.tugas:
        return 'Tugas';
      case NoteCategory.ide:
        return 'Ide';
      case NoteCategory.pribadi:
        return 'Pribadi';
      case NoteCategory.organisasi:
        return 'Organisasi';
    }
  }

  IconData get icon {
    switch (this) {
      case NoteCategory.kuliah:
        return Icons.school_rounded;
      case NoteCategory.tugas:
        return Icons.assignment_rounded;
      case NoteCategory.ide:
        return Icons.lightbulb_rounded;
      case NoteCategory.pribadi:
        return Icons.coffee_rounded;
      case NoteCategory.organisasi:
        return Icons.groups_rounded;
    }
  }
}

/// Enumerasi Prioritas Catatan
enum NotePriority {
  rendah,
  sedang,
  tinggi;

  String get label {
    switch (this) {
      case NotePriority.rendah:
        return 'Rendah';
      case NotePriority.sedang:
        return 'Sedang';
      case NotePriority.tinggi:
        return 'Tinggi';
    }
  }

  Color get color {
    switch (this) {
      case NotePriority.rendah:
        return AppTheme.priorityLow;
      case NotePriority.sedang:
        return AppTheme.priorityMedium;
      case NotePriority.tinggi:
        return AppTheme.priorityHigh;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case NotePriority.rendah:
        return const Color(0xFFE8F5E9);
      case NotePriority.sedang:
        return const Color(0xFFFFF3E0);
      case NotePriority.tinggi:
        return const Color(0xFFFFEBEE);
    }
  }
}

/// Model Data Utama untuk Catatan Pengguna
class Note {
  final String id;
  final String title;
  final String content;
  final NoteCategory category;
  final NotePriority priority;
  final int colorValue;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.priority,
    required this.colorValue,
    required this.createdAt,
  });

  /// Mengambil representasi Color dari nilai integer
  Color get color => Color(colorValue);

  /// Format tanggal ramah pengguna: "25 Okt 2026 • 14:30"
  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final day = createdAt.day.toString().padLeft(2, '0');
    final month = months[createdAt.month - 1];
    final year = createdAt.year;
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$day $month $year • $hour:$minute';
  }

  /// Format tanggal ringkas: "25 Okt"
  String get shortDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${createdAt.day} ${months[createdAt.month - 1]}';
  }

  /// Membuat salinan objek dengan modifikasi nilai tertentu (Immutable Pattern)
  Note copyWith({
    String? id,
    String? title,
    String? content,
    NoteCategory? category,
    NotePriority? priority,
    int? colorValue,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
