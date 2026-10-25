import 'package:flutter_test/flutter_test.dart';
import 'package:catatanku_4342501001/main.dart';

void main() {
  testWidgets('Aplikasi CatatanKu menampilkan Splash Screen pada awal mulai', (WidgetTester tester) async {
    // Membangun aplikasi CatatanKu
    await tester.pumpWidget(const CatatanKuApp());

    // Memverifikasi teks nama aplikasi dan identitas muncul di Splash Screen
    expect(find.text('CatatanKu'), findsOneWidget);
    expect(find.text('NIM: 4342501001'), findsOneWidget);
  });
}
