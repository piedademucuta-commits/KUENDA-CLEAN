import 'package:flutter_test/flutter_test.dart';

import 'package:kuenda_clean/main.dart';

void main() {
  testWidgets(
    'Kuenda Clean inicia corretamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const KuendaClean(),
      );

      expect(
        find.byType(KuendaClean),
        findsOneWidget,
      );
    },
  );
}
