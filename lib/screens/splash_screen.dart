import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import 'login_screen.dart';

/// Halaman 1: Splash Screen
/// Berfungsi sebagai halaman pembuka dengan logo orisinal CatatanKu,
/// slogan inspiratif, dan transisi otomatis menuju Halaman Login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // Animasi munculnya logo & teks secara halus
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();

    // Berpindah secara otomatis ke halaman login setelah 4 detik (atau ketuk layar untuk lewati)
    _navigationTimer = Timer(const Duration(milliseconds: 4000), _navigateToLogin);
  }

  void _navigateToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      body: GestureDetector(
        onTap: _navigateToLogin, // Memungkinkan klik langsung tanpa menunggu timer
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Lingkaran dekoratif latar belakang (Soft Blush Glow)
            Positioned(
              top: -size.width * 0.25,
              right: -size.width * 0.2,
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryBlushLight.withValues(alpha: 0.2),
                ),
              ),
            ),
            Positioned(
              bottom: -size.width * 0.3,
              left: -size.width * 0.2,
              child: Container(
                width: size.width * 0.9,
                height: size.width * 0.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.noteColorCream.withValues(alpha: 0.6),
                ),
              ),
            ),

            // Konten Tengah
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo Orisinal
                        const AppLogo(size: 96),
                        const SizedBox(height: 24),

                        // Nama Aplikasi
                        const Text(
                          'CatatanKu',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryBlushDark,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Slogan Inspiratif
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            'Ruang Hangat untuk Setiap Ide, Rencana, & Inspirasimu',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary.withValues(alpha: 0.9),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Indikator Loading Lembut
                        SizedBox(
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              minHeight: 4,
                              backgroundColor: AppTheme.borderLight,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryBlush,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Footer Identitas Mahasiswa / Versi
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'TUGAS INDIVIDU 02 • PEMROGRAMAN MOBILE',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textLight.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'NIM: 4342501001',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryBlush,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
