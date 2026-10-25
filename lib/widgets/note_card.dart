import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';
import 'priority_badge.dart';

/// NoteCard adalah komponen kartu ringkasan catatan yang ditampilkan pada daftar Beranda.
/// Memadukan warna aksen pastel kartu dengan tipografi yang jelas dan mudah dibaca.
class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.primaryBlush.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlush.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Kartu: Kategori & Badge Prioritas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceWhite.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            note.category.icon,
                            size: 14,
                            color: AppTheme.primaryBlush,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            note.category.label,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryBlushDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PriorityBadge(priority: note.priority, compact: true),
                  ],
                ),
                const SizedBox(height: 12),

                // Judul Catatan
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),

                // Cuplikan Isi Catatan
                Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                // Footer Kartu: Tanggal & Aksi Cepat
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 13,
                          color: AppTheme.textSecondary.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          note.formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textSecondary.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceWhite.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: AppTheme.primaryBlush,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
