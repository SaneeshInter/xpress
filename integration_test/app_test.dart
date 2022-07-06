import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:xpresshealthdev/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login', () {
    testWidgets('check Multiple login',
            (tester) async {
              app.main();
              await tester.pumpAndSettle();
              await Future.delayed(const Duration(seconds: 10000000));

          // expect(find.text('0'), findsOneWidget);
          //
          // // Finds the floating action button to tap on.
          // final Finder fab = find.byTooltip('Increment');
          //
          // // Emulate a tap on the floating action button.
          // await tester.tap(fab);
          //
          // // Trigger a frame.
          // await tester.pumpAndSettle();
          //
          // // Verify the counter increments by 1.
          // expect(find.text('1'), findsOneWidget);
        });
  });
}