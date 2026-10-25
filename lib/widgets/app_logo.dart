import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// AppLogo adalah komponen logo orisinal untuk aplikasi CatatanKu.
/// Didesain menggunakan vector widget murni (Container, Gradient, Shadows, Stack,
/// dan Icons) yang melambangkan buku catatan hangat dengan aksen pena dan kilauan ide.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showShadow;

  const AppLogo({
    super.key,
    this.size = 80.0,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(size * 0.28);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlush,
            Color(0xFFE58C9D),
            AppTheme.accentPeach,
          ],
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppTheme.primaryBlush.withValues(alpha: 0.35),
                  blurRadius: size * 0.25,
                  offset: Offset(0, size * 0.1),
                ),
              ]
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Aksen lingkaran dekoratif di latar belakang logo
          Positioned(
            top: -size * 0.1,
            right: -size * 0.1,
            child: Container(
              width: size * 0.5,
              height: size * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
          // Ikon Buku Catatan Utama
          Icon(
            Icons.menu_book_rounded,
            size: size * 0.48,
            color: Colors.white,
          ),
          // Ikon Pena & Kilau Ide di sudut kanan bawah
          Positioned(
            right: size * 0.12,
            bottom: size * 0.12,
            child: Container(
              padding: EdgeInsets.all(size * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.edit_rounded,
                size: size * 0.22,
                color: AppTheme.primaryBlush,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
