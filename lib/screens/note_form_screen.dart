import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';

/// Halaman 4: Tambah Catatan (Form Input)
/// Mendukung pembuatan catatan baru serta pengeditan catatan yang sudah ada.
/// Dilengkapi pemilihan judul, isi, kategori, prioritas, dan warna kartu.
class NoteFormScreen extends StatefulWidget {
  final Note? noteToEdit;

  const NoteFormScreen({super.key, this.noteToEdit});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late NoteCategory _selectedCategory;
  late NotePriority _selectedPriority;
  late int _selectedColorValue;

  bool get _isEditing => widget.noteToEdit != null;

  @override
  void initState() {
    super.initState();
    final note = widget.noteToEdit;
    _titleController = TextEditingController(text: note?.title ?? '');
    _contentController = TextEditingController(text: note?.content ?? '');
    _selectedCategory = note?.category ?? NoteCategory.kuliah;
    _selectedPriority = note?.priority ?? NotePriority.sedang;
    _selectedColorValue = note?.colorValue ?? AppTheme.selectableColors.first.toARGB32();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState?.validate() ?? false) {
      final now = DateTime.now();
      final savedNote = Note(
        id: widget.noteToEdit?.id ?? 'note-${now.millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        priority: _selectedPriority,
        colorValue: _selectedColorValue,
        createdAt: widget.noteToEdit?.createdAt ?? now,
      );

      Navigator.of(context).pop(savedNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Catatan' : 'Tulis Catatan Baru'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton.icon(
            onPressed: _saveNote,
            icon: const Icon(Icons.check_rounded, color: AppTheme.primaryBlush, size: 20),
            label: const Text(
              'Simpan',
              style: TextStyle(
                color: AppTheme.primaryBlush,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 36.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Judul Catatan
                CustomTextField(
                  controller: _titleController,
                  labelText: 'Judul Catatan',
                  hintText: 'Misal: Rangkuman Kuliah, Ide Proyek...',
                  prefixIcon: Icons.title_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Judul catatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Pilihan Kategori
                const Text(
                  'Kategori Catatan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: NoteCategory.values.map((category) {
                    final isSelected = _selectedCategory == category;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryBlush : AppTheme.surfaceWhite,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryBlush : AppTheme.borderLight,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category.icon,
                              size: 16,
                              color: isSelected ? Colors.white : AppTheme.primaryBlush,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category.label,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),

                // Pilihan Prioritas
                const Text(
                  'Tingkat Prioritas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: NotePriority.values.map((priority) {
                    final isSelected = _selectedPriority == priority;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedPriority = priority;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              color: isSelected ? priority.backgroundColor : AppTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? priority.color : AppTheme.borderLight,
                                width: isSelected ? 1.6 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: priority.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  priority.label,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected ? priority.color : AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),

                // Pilihan Warna Kartu Catatan
                const Text(
                  'Warna Kartu',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: AppTheme.selectableColors.map((color) {
                    final isSelected = _selectedColorValue == color.toARGB32();
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorValue = color.toARGB32();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 14),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryBlush : AppTheme.borderLight,
                            width: isSelected ? 2.5 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check_rounded,
                                color: AppTheme.primaryBlush,
                                size: 22,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),

                // Input Isi Catatan
                CustomTextField(
                  controller: _contentController,
                  labelText: 'Isi Catatan',
                  hintText: 'Tuliskan detail catatan, ide, atau materi kuliahmu di sini...',
                  minLines: 8,
                  maxLines: 15,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Isi catatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Simpan Besar di Bagian Bawah
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saveNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlush,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.save_rounded, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          _isEditing ? 'Simpan Perubahan' : 'Simpan Catatan',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
