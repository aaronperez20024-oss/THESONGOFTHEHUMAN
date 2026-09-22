import 'package:flutter_test/flutter_test.dart';
import 'package:vibe_music/main.dart';

void main() {
  testWidgets('Vibe app renders the home greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const VibeApp());
    await tester.pump();
    expect(find.textContaining('Buenas noches'), findsOneWidget);
  });
}
