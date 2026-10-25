import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// CategoryChip adalah komponen pill yang dapat diklik untuk memilih kategori
/// catatan, baik pada filter di Beranda maupun pada formulir Tambah/Edit.
class CategoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final int? count;

  const CategoryChip({
    super.key,
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryBlush : AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryBlush
                    : AppTheme.borderLight,
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryBlush.withValues(alpha: 0.28),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected ? Colors.white : AppTheme.primaryBlush,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                if (count != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.25)
                          : AppTheme.primaryBlush.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : AppTheme.primaryBlush,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
