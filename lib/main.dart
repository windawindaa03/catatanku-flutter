import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

/// Titik Masuk Utama (Main Entry Point) Aplikasi CatatanKu
/// Tugas Individu 02 - Uji Pemahaman Fase 2: Perancangan UI Flutter
/// Nama Mahasiswa : Winda
/// NIM            : 4342501001
void main() {
  // Memastikan binding Flutter terinisialisasi sebelum menjalankan konfigurasi sistem
  WidgetsFlutterBinding.ensureInitialized();

  // Mengatur warna status bar dan navigasi sistem Android agar serasi dengan tema Cream
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppTheme.backgroundCream,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const CatatanKuApp());
}

/// Custom ScrollBehavior agar aplikasi mendukung scrolling menggunakan mouse/trackpad (emulator PC)
/// maupun sentuhan layar (touch) pada perangkat Android fisik.
class CatatanKuScrollBehavior extends MaterialScrollBehavior {
  const CatatanKuScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

/// Root Widget Aplikasi CatatanKu
class CatatanKuApp extends StatelessWidget {
  const CatatanKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatatanKu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Mengaktifkan scroll behavior interaktif untuk touch & mouse emulator
      scrollBehavior: const CatatanKuScrollBehavior(),
      // Halaman pertama yang dibuka adalah Splash Screen (Halaman 1)
      home: const SplashScreen(),
    );
  }
}
