import 'package:flutter/material.dart';

/// AppTheme mengelola seluruh palet warna, tipografi, dan gaya komponen
/// untuk aplikasi CatatanKu. Menggunakan kombinasi warna Blush Pink dan Cream
/// yang hangat, estetik, dan nyaman di mata pengguna.
class AppTheme {
  // --- PALET WARNA UTAMA (BLUSH PINK & CREAM) ---
  static const Color primaryBlush = Color(0xFFC86B7E);       // Blush Rose pekat untuk tombol & aksen utama
  static const Color primaryBlushLight = Color(0xFFF3C1CC);  // Blush Rose muda untuk latar belakang aksen
  static const Color primaryBlushDark = Color(0xFFA64A5E);   // Blush pekat untuk kontras gelap
  static const Color accentPeach = Color(0xFFF4A261);        // Aksen Peach hangat untuk variasi elemen

  // Latar belakang dan permukaan kartu (Cream & Ivory)
  static const Color backgroundCream = Color(0xFFFDFBF7);    // Warna dasar layar (hangat & bebas silau)
  static const Color surfaceWhite = Color(0xFFFFFFFF);       // Warna kartu utama
  static const Color surfaceCreamLight = Color(0xFFFFF9F5);  // Warna kartu dengan rona krem lembut
  static const Color borderLight = Color(0xFFEFE6E4);        // Garis batas (border) halus

  // Tipografi (Warna Teks Berkebalikan dengan Latar Belakang)
  static const Color textPrimary = Color(0xFF2E2426);        // Teks utama (Warm Charcoal, kontras tinggi)
  static const Color textSecondary = Color(0xFF7A6E71);      // Teks sekunder (Muted Slate)
  static const Color textLight = Color(0xFFAB9FA2);          // Teks penjelas / placeholder

  // Warna Aksen untuk Kategori & Pilihan Kartu Catatan
  static const Color noteColorBlush = Color(0xFFFCEEEF);     // Soft Blush Pink
  static const Color noteColorCream = Color(0xFFFFF6E5);     // Soft Warm Cream / Peach
  static const Color noteColorMint = Color(0xFFE8F5E9);      // Soft Mint Green
  static const Color noteColorLavender = Color(0xFFEDE7F6);  // Soft Pastel Lavender
  static const Color noteColorSky = Color(0xFFE1F5FE);       // Soft Sky Blue

  // Warna Indikator Prioritas
  static const Color priorityLow = Color(0xFF43A047);        // Hijau lembut untuk Prioritas Rendah
  static const Color priorityMedium = Color(0xFFFB8C00);     // Oranye hangat untuk Prioritas Sedang
  static const Color priorityHigh = Color(0xFFE53935);       // Merah tegas untuk Prioritas Tinggi

  // Daftar warna kartu yang dapat dipilih pengguna saat membuat/mengedit catatan
  static const List<Color> selectableColors = [
    noteColorBlush,
    noteColorCream,
    noteColorMint,
    noteColorLavender,
    noteColorSky,
  ];

  /// Definisi ThemeData global untuk MaterialApp
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlush,
        primary: primaryBlush,
        surface: surfaceWhite,
      ),
      fontFamily: 'sans-serif',
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundCream,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 1.5,
        shadowColor: primaryBlush.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlush,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryBlush.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: textLight, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryBlush, width: 1.8),
        ),
      ),
    );
  }
}
