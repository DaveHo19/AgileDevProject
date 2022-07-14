import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/testing-purpose/test_wishlist_function.dart' as testapp;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end test", (){
    testWidgets("tap on the add wishlist icon", (tester) async {
      testapp.main();
      await tester.pumpAndSettle();
      //initial wishlist lenght
      expect(find.text('0'), findsOneWidget);

      //bind the wishlist icon button 
      final Finder wishlistButton = find.byTooltip("wishlist_button");
      //click event on wishlist button
      await tester.tap(wishlistButton);
      //refresh scene
      await tester.pumpAndSettle();
      //expect the wishlist length increases to 1
      expect(find.text('1'), findsOneWidget);
      //another click event on wishlist button
      await tester.tap(wishlistButton);
      //refresh scene
      await tester.pumpAndSettle();
      //expect the wishlist length decrease to 0
      expect(find.text('0'), findsOneWidget);
    });
  }); 
}