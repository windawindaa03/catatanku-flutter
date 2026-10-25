import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';
import '../widgets/priority_badge.dart';
import 'note_form_screen.dart';

/// Halaman 5: Detail Catatan
/// Menampilkan informasi catatan secara lengkap termasuk judul, kategori,
/// prioritas, tanggal pembuatan, dan isi catatan. Dilengkapi fitur edit dan hapus.
class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note _currentNote;
  bool _hasBeenEdited = false;

  @override
  void initState() {
    super.initState();
    _currentNote = widget.note;
  }

  /// Menavigasi ke formulir Edit Catatan
  Future<void> _navigateToEdit() async {
    final updatedNote = await Navigator.of(context).push<Note>(
      MaterialPageRoute(
        builder: (context) => NoteFormScreen(noteToEdit: _currentNote),
      ),
    );

    if (updatedNote != null) {
      setState(() {
        _currentNote = updatedNote;
        _hasBeenEdited = true;
      });
    }
  }

  /// Menampilkan dialog konfirmasi penghapusan catatan
  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppTheme.priorityHigh, size: 26),
            SizedBox(width: 10),
            Text(
              'Hapus Catatan?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Catatan "${_currentNote.title}" akan dihapus dari daftar.',
          style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.priorityHigh,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Hapus', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (shouldDelete == true && mounted) {
      Navigator.of(context).pop('DELETED');
    }
  }

  /// Menyalin isi catatan ke clipboard
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: '${_currentNote.title}\n\n${_currentNote.content}'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.copy_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Isi catatan disalin ke papan klip!'),
          ],
        ),
        backgroundColor: AppTheme.primaryBlush,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung jumlah kata dan karakter
    final wordCount = _currentNote.content.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
    final charCount = _currentNote.content.length;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // Jika didPop true dan catatan sudah pernah diedit namun belum dikembalikan
        if (_hasBeenEdited && result == null) {
          // Navigator pop akan membawa _currentNote bila dipanggil secara manual
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundCream,
        appBar: AppBar(
          title: const Text('Detail Catatan'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () {
              Navigator.of(context).pop(_hasBeenEdited ? _currentNote : null);
            },
          ),
          actions: [
            // Tombol Salin
            IconButton(
              tooltip: 'Salin Teks',
              icon: const Icon(Icons.copy_rounded, size: 20, color: AppTheme.textSecondary),
              onPressed: _copyToClipboard,
            ),
            // Tombol Edit Catatan
            IconButton(
              tooltip: 'Edit Catatan',
              icon: const Icon(Icons.edit_rounded, size: 20, color: AppTheme.primaryBlush),
              onPressed: _navigateToEdit,
            ),
            // Tombol Hapus Catatan
            IconButton(
              tooltip: 'Hapus Catatan',
              icon: const Icon(Icons.delete_outline_rounded, size: 22, color: AppTheme.priorityHigh),
              onPressed: _confirmDelete,
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner Kartu Berwarna
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _currentNote.color,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppTheme.primaryBlush.withValues(alpha: 0.18),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris Kategori, Prioritas, & Aksen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _currentNote.category.icon,
                                  size: 15,
                                  color: AppTheme.primaryBlush,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _currentNote.category.label,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryBlushDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PriorityBadge(priority: _currentNote.priority),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Tanggal Pembuatan / Pembaruan
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Dibuat: ${_currentNote.formattedDate}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Judul Catatan Lengkap
                Text(
                  _currentNote.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Baris Info Panjang Teks
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.borderLight.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$wordCount kata • $charCount karakter',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppTheme.borderLight, thickness: 1),
                const SizedBox(height: 16),

                // Isi Catatan
                SelectableText(
                  _currentNote.content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                    height: 1.65,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
