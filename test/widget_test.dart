import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnova/main.dart';

void main() {
  testWidgets('Learnova app renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: LearnovaApp(),
      ),
    );
    // Drain all splash screen initialization timers
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(LearnovaApp), findsOneWidget);
  });
}
