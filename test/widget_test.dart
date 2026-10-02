import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exre/main.dart';

void main() {
  testWidgets('ExRE arranca en Inicio y navega a Catalogo', (WidgetTester tester) async {
    await tester.pumpWidget(const ExreApp());
    await tester.pumpAndSettle();

    expect(find.text('ExRE'), findsOneWidget);
    expect(find.text('Accesos rapidos'), findsOneWidget);

    await tester.tap(find.text('Catalogo').last);
    await tester.pumpAndSettle();

    expect(find.text('Catalogo'), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Marcar un recurso como favorito lo agrega a Favoritos', (WidgetTester tester) async {
    await tester.pumpWidget(const ExreApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(InkWell, 'Catalogo').first);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite_rounded).last);
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing);
    expect(find.text('Favoritos'), findsWidgets);
  });
}
