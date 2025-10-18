import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/home_page.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  testWidgets('Wheather display -', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    final weatherTabFinder = find.byKey(Key('weather'));
    expect(find.byType(TextFormField), findsNWidgets(4));

    await tester.tap(weatherTabFinder);

    await tester.pump();
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(WeatherDisplay), findsOneWidget);
  });
}
