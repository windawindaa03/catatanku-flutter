import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/note_card.dart';
import 'note_detail_screen.dart';
import 'note_form_screen.dart';

/// Halaman 3: Beranda (Home Screen)
/// Menampilkan ringkasan aktivitas, pencarian real-time, filter kategori,
/// daftar kartu catatan, serta navigasi untuk menambah dan mengelola catatan.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State lokal daftar catatan (diinisialisasi dari dummy data mahasiswa)
  late List<Note> _notes;

  // State untuk pencarian dan filter kategori
  String _searchQuery = '';
  NoteCategory? _selectedCategory; // null = Semua kategori
  int _currentBottomNavIndex = 0;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _notes = List.from(DummyData.initialNotes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Memfilter catatan berdasarkan kategori yang dipilih dan kata kunci pencarian
  List<Note> get _filteredNotes {
    return _notes.where((note) {
      final matchesCategory = _selectedCategory == null || note.category == _selectedCategory;
      final query = _searchQuery.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  /// Menghitung total catatan untuk kategori tertentu
  int _countByCategory(NoteCategory? category) {
    if (category == null) return _notes.length;
    return _notes.where((n) => n.category == category).length;
  }

  /// Menghitung jumlah catatan berprioritas tinggi
  int get _highPriorityCount {
    return _notes.where((n) => n.priority == NotePriority.tinggi).length;
  }

  /// Menavigasi ke formulir Tambah Catatan
  Future<void> _navigateToAddNote() async {
    final result = await Navigator.of(context).push<Note>(
      MaterialPageRoute(builder: (context) => const NoteFormScreen()),
    );

    if (result != null) {
      setState(() {
        _notes.insert(0, result);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Catatan "${result.title}" berhasil disimpan! 📝',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.primaryBlush,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  /// Menavigasi ke Halaman Detail Catatan
  Future<void> _navigateToDetail(Note note) async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );

    // Tangani hasil kembalian dari Detail (Edit atau Hapus)
    if (result is Note) {
      // Catatan telah diperbarui (Edit)
      setState(() {
        final index = _notes.indexWhere((n) => n.id == result.id);
        if (index != -1) {
          _notes[index] = result;
        }
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.edit_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Perubahan catatan berhasil disimpan! ✨',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: AppTheme.primaryBlush,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else if (result == 'DELETED') {
      // Catatan telah dihapus
      setState(() {
        _notes.removeWhere((n) => n.id == note.id);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.delete_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Catatan "${note.title}" telah dihapus! 🗑️',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.priorityHigh,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          radius: const Radius.circular(8),
          thickness: 5,
          child: SingleChildScrollView(
            controller: _scrollController,
            // Memastikan halaman selalu dapat di-scroll dengan efek pantul halus (bouncing)
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Atas: Sapaan Pengguna & Profil
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Halo, Winda! ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textPrimary,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.noteColorCream,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('✨ Mahasiswa', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryBlushDark)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Minggu, 25 Oktober 2026',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Avatar Profil
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Profil Mahasiswa: Winda (NIM: 4342501001)'),
                            backgroundColor: AppTheme.primaryBlush,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.primaryBlush, AppTheme.accentPeach],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryBlush.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'W',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Banner Ringkasan Aktivitas (Activity Banner)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppTheme.primaryBlush,
                        Color(0xFFE2899A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryBlush.withValues(alpha: 0.28),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ruang Catatan Aktif 📖',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Total ${_notes.length} catatan tersimpan, $_highPriorityCount prioritas penting.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.92),
                                fontSize: 13,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${_notes.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              'Catatan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Kolom Pencarian Catatan (Real-time Filter)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari judul atau isi catatan...',
                    hintStyle: const TextStyle(color: AppTheme.textLight, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryBlush),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            color: AppTheme.textSecondary,
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.surfaceWhite,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppTheme.borderLight),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppTheme.borderLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppTheme.primaryBlush, width: 1.8),
                    ),
                  ),
                ),
              ),

              // Baris Filter Kategori (Horizontal Scrollable Chips)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Chip "Semua"
                    CategoryChip(
                      label: 'Semua',
                      icon: Icons.grid_view_rounded,
                      isSelected: _selectedCategory == null,
                      count: _countByCategory(null),
                      onTap: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),

                    // Chip Kategori Lainnya
                    ...NoteCategory.values.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CategoryChip(
                          label: cat.label,
                          icon: cat.icon,
                          isSelected: _selectedCategory == cat,
                          count: _countByCategory(cat),
                          onTap: () {
                            setState(() {
                              _selectedCategory = (_selectedCategory == cat) ? null : cat;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Subheader Jumlah Catatan
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory == null
                          ? 'Semua Catatan (${filtered.length})'
                          : 'Kategori: ${_selectedCategory!.label} (${filtered.length})',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      Text(
                        'Hasil untuk "$_searchQuery"',
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.primaryBlush,
                        ),
                      ),
                  ],
                ),
              ),

              // Daftar Kartu Catatan atau Empty State jika kosong
              if (filtered.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: AppTheme.noteColorCream,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: AppTheme.primaryBlush,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tidak ada catatan ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'Coba gunakan kata kunci pencarian yang berbeda.'
                              : 'Belum ada catatan pada kategori ini. Tekan tombol Tambah untuk membuat catatan baru!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: filtered.map((note) {
                      return NoteCard(
                        note: note,
                        onTap: () => _navigateToDetail(note),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),

      // Tombol Tambah Catatan (Floating Action Button)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddNote,
        backgroundColor: AppTheme.primaryBlush,
        foregroundColor: Colors.white,
        elevation: 3,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: const Text(
          'Tambah Catatan',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
            if (index != 0) {
              final labels = ['Beranda', 'Kategori', 'Arsip', 'Profil'];
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Menu ${labels[index]}: Aktif di halaman Beranda.'),
                  backgroundColor: AppTheme.primaryBlush,
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            }
          },
          backgroundColor: AppTheme.surfaceWhite,
          selectedItemColor: AppTheme.primaryBlush,
          unselectedItemColor: AppTheme.textLight,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Kategori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Arsip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
