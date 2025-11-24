import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookloop_mobile/main.dart' as app;

void main() {
  testWidgets('App navigation smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: app.BookLoopApp()));

    // initial screen should show welcoming text
    expect(find.text('Welcome to BookLoop'), findsOneWidget);

    // tap the button that opens the next screen
    await tester.tap(find.text('Open next screen'));
    await tester.pumpAndSettle();

    expect(find.text('Screen 02'), findsWidgets);
  });
}
