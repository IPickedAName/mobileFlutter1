import 'package:flutter_test/flutter_test.dart';
import 'package:my_quiz/main.dart';

void main() {
  testWidgets('Initial state shows Expression, Solution, Play', (WidgetTester tester) async {
    await tester.pumpWidget(const MyQuizApp());
    expect(find.text('Expression'), findsOneWidget);
    expect(find.text('Solution'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
  });
}
