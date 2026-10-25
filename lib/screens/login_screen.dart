import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

/// Halaman 2: Login Statis
/// Menyediakan antarmuka autentikasi dengan identitas visual Blush Pink & Cream.
/// Dilengkapi validasi sederhana dan navigasi langsung ke Halaman Beranda.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'winda@student.ac.id');
  final _passwordController = TextEditingController(text: 'catatanku2026');
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Tampilkan notifikasi feedback ramah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Berhasil masuk! Selamat datang kembali ✨',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: AppTheme.primaryBlush,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigasi ke Beranda
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo dan Salam
                  const Center(child: AppLogo(size: 80)),
                  const SizedBox(height: 20),

                  const Text(
                    'CatatanKu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primaryBlushDark,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Masuk untuk melanjutkan jurnal & catatan harianmu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Input Email
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Alamat Email',
                    hintText: 'nama@student.ac.id',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!value.contains('@')) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Input Password
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Kata Sandi',
                    hintText: 'Masukkan kata sandi Anda',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kata sandi tidak boleh kosong';
                      }
                      if (value.length < 4) {
                        return 'Kata sandi minimal 4 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Baris Ingat Saya & Lupa Sandi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppTheme.primaryBlush,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _rememberMe = val ?? true;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Ingat saya',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Fitur lupa sandi: Tautan reset dikirim ke email mahasiswa.',
                              ),
                              backgroundColor: AppTheme.primaryBlush,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Lupa kata sandi?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryBlush,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tombol Masuk Utama
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.primaryBlush,
                          Color(0xFFDC788B),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlush.withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Masuk ke CatatanKu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Pembatas "atau"
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: AppTheme.borderLight, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'atau masuk dengan',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textLight.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: AppTheme.borderLight, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tombol Masuk dengan Google / Akun Kampus
                  OutlinedButton.icon(
                    onPressed: _handleLogin,
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: AppTheme.primaryBlush,
                      size: 20,
                    ),
                    label: const Text(
                      'Masuk dengan Akun Kampus / Google',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: const BorderSide(color: AppTheme.borderLight, width: 1.2),
                      backgroundColor: AppTheme.surfaceWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Footer Daftar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum memiliki akun? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Mode demo frontend: Pendaftaran akun baru otomatis aktif.',
                              ),
                              backgroundColor: AppTheme.primaryBlush,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryBlushDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
