// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bai2/food_delivery_app.dart';

void main() {
  test('food catalogue has the restaurants and dishes from the design', () {
    expect(sampleRestaurants, hasLength(4));
    expect(sampleRestaurants.first.name, 'Casa Napoli');
    expect(sampleRestaurants.first.items.first.name, 'Truffle Burrata');
    expect(sampleRestaurants.first.items.first.price, 18.90);
  });

  testWidgets('Popular near you header opens the restaurant list', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pump();
    await tester.tap(find.text('Popular near you'));
    await tester.pumpAndSettle();

    expect(find.text('Find your next favorite'), findsOneWidget);
  });

  testWidgets('More to explore header opens the restaurant list', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pump();
    await tester.drag(find.byType(CustomScrollView).first, const Offset(0, -800));
    await tester.pumpAndSettle();
    final section = find.text('More to explore');
    await tester.tap(section);
    await tester.pumpAndSettle();

    expect(find.text('Find your next favorite'), findsOneWidget);
  });

  testWidgets('a restaurant card opens its menu', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pump();
    final restaurant = find.text('Casa Napoli').first;
    await tester.ensureVisible(restaurant);
    await tester.tap(restaurant);
    await tester.pumpAndSettle();

    expect(find.text('Authentic Italian · Pizza · Pasta'), findsOneWidget);
    expect(find.text('Truffle Burrata'), findsOneWidget);
  });

  testWidgets('More to explore restaurant opens its menu', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pump();
    await tester.drag(find.byType(CustomScrollView).first, const Offset(0, -800));
    await tester.pumpAndSettle();
    final restaurant = find.text('Green & Grain').last;
    await tester.tap(restaurant);
    await tester.pumpAndSettle();

    expect(find.text('Authentic Healthy · Bowls · Salads'), findsOneWidget);
  });
}
