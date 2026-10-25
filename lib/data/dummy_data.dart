import '../models/note_model.dart';
import '../theme/app_theme.dart';

/// Data catatan awal (mock/dummy data) yang realistis untuk kebutuhan mahasiswa.
/// Data ini disimpan di dalam memori selama sesi aplikasi berjalan.
class DummyData {
  static List<Note> get initialNotes => [
    Note(
      id: 'note-1',
      title: 'Rangkuman Materi Kuliah Pemrograman Mobile',
      content:
          'Poin-poin penting pertemuan minggu ini:\n'
          '1. Pemahaman mendasar tentang Widget Tree di Flutter.\n'
          '2. Perbedaan StatelessWidget (antarmuka statis tanpa perubahan state) '
          'dan StatefulWidget (antarmuka dinamis yang dapat berubah saat setState dipanggil).\n'
          '3. Pengelolaan tema global menggunakan ThemeData dan ColorScheme.\n'
          '4. Best practice memisahkan kode UI menjadi reusable widgets agar rapi dan mudah di-maintain.',
      category: NoteCategory.kuliah,
      priority: NotePriority.tinggi,
      colorValue: AppTheme.noteColorBlush.toARGB32(),
      createdAt: DateTime(2026, 10, 24, 9, 30),
    ),
    Note(
      id: 'note-2',
      title: 'Ide Desain & Konsep Aplikasi CatatanKu',
      content:
          'Konsep aplikasi buku catatan digital dengan nuansa hangat Blush Pink & Cream.\n'
          '- Mengutamakan kenyamanan mata pengguna saat membaca catatan dalam waktu lama.\n'
          '- Menggunakan navigasi yang intuitif: Beranda dengan filter kategori cepat, formulir pencatatan yang responsif, dan detail lengkap dengan fitur edit/hapus.\n'
          '- Logo orisinal berupa buku catatan terbuka dengan aksen pena dan kilau ide kreatif.',
      category: NoteCategory.ide,
      priority: NotePriority.sedang,
      colorValue: AppTheme.noteColorLavender.toARGB32(),
      createdAt: DateTime(2026, 10, 23, 15, 45),
    ),
    Note(
      id: 'note-3',
      title: 'Jadwal Belajar Persiapan UTS Semester Ini',
      content:
          'Rencana jadwal belajar intensif sebelum pekan ujian:\n'
          '- Senin: Review materi Basis Data Relasional & Query SQL.\n'
          '- Selasa: Latihan slicing UI Flutter & navigasi antar halaman.\n'
          '- Rabu: Rekayasa Perangkat Lunak (Diagram UML & Agile Scrum).\n'
          '- Kamis: Jaringan Komputer & protokol TCP/IP.\n'
          'Target: Selesaikan semua latihan soal sebelum hari Jumat.',
      category: NoteCategory.tugas,
      priority: NotePriority.tinggi,
      colorValue: AppTheme.noteColorCream.toARGB32(),
      createdAt: DateTime(2026, 10, 22, 19, 15),
    ),
    Note(
      id: 'note-4',
      title: 'Daftar Kebutuhan & Belanja Kos Mingguan',
      content:
          'Catatan belanja mingguan di supermarket dekat kampus:\n'
          '- Beras 5 kg & minyak goreng kemasan\n'
          '- Telur ayam 1 kg & tahu/tempe segar\n'
          '- Susu almond, oatmeal, & buah pisang\n'
          '- Kopi sachet untuk teman belajar malam\n'
          '- Sabun cuci pakaian & pasta gigi',
      category: NoteCategory.pribadi,
      priority: NotePriority.rendah,
      colorValue: AppTheme.noteColorMint.toARGB32(),
      createdAt: DateTime(2026, 10, 21, 11, 20),
    ),
    Note(
      id: 'note-5',
      title: 'Agenda Rapat Divisi Acara Seminar Teknologi',
      content:
          'Hasil koordinasi panitia seminar nasional:\n'
          '1. Konfirmasi pembicara tamu dari industri teknologi.\n'
          '2. Finalisasi proposal sponsor untuk diserahkan ke pihak dekanat.\n'
          '3. Gladi bersih teknis proyektor, audio, dan live streaming H-1.\n'
          '4. Koordinasi konsumsi bersama divisi logistik.',
      category: NoteCategory.organisasi,
      priority: NotePriority.sedang,
      colorValue: AppTheme.noteColorSky.toARGB32(),
      createdAt: DateTime(2026, 10, 20, 16, 00),
    ),
    Note(
      id: 'note-6',
      title: 'Target Membaca Buku & Self Development',
      content:
          'Buku target bulan ini: Clean Code oleh Robert C. Martin.\n'
          'Fokus utama:\n'
          '- Memberi nama variabel & fungsi yang deskriptif dan bermakna.\n'
          '- Menulis fungsi kecil yang hanya mengerjakan satu tugas utama (Single Responsibility).\n'
          '- Menghindari komentar berlebihan yang hanya mengulang baris kode.',
      category: NoteCategory.pribadi,
      priority: NotePriority.rendah,
      colorValue: AppTheme.noteColorCream.toARGB32(),
      createdAt: DateTime(2026, 10, 19, 20, 10),
    ),
  ];
}
