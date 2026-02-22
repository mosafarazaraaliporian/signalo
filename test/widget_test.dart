import 'package:flutter_test/flutter_test.dart';

import 'package:signalo/main.dart';

void main() {
  testWidgets('Splash screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const SignaloApp());
    
    expect(find.text('SIGNALO'), findsOneWidget);
    expect(find.text('سیگنال‌های کریپتو و فارکس'), findsOneWidget);
  });
}
