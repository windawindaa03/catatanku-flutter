import 'package:flutter/material.dart';
import '../models/note_model.dart';

/// PriorityBadge menampilkan label prioritas catatan (Rendah, Sedang, Tinggi)
/// dengan warna latar dan titik indikator yang harmonis.
class PriorityBadge extends StatelessWidget {
  final NotePriority priority;
  final bool compact;

  const PriorityBadge({
    super.key,
    required this.priority,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: priority.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: priority.color.withValues(alpha: 0.35),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6 : 7,
            height: compact ? 6 : 7,
            decoration: BoxDecoration(
              color: priority.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            priority.label,
            style: TextStyle(
              color: priority.color,
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
