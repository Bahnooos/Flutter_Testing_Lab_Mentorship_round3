import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/card_item.dart';
import 'package:flutter_testing_lab/widgets/items_service.dart';

void main() {
  late List<CartItem> items;
  late ItemsService itemsService;
  setUp(() {
    items = [
      CartItem(
        id: '1',
        name: 'Iphone',
        price: 999.99,
        discount: .1,
        quantity: 3,
      ),
      CartItem(
        id: '2',
        name: 'Samsung',
        price: 899.99,
        discount: .15,
        quantity: 2,
      ),
    ];
    itemsService = ItemsService();
  });

  group(' Item Service -', () {
    /// test add Item Method
    test('give item service when call addItem then add item', () {
      // Arrange
      // Act :
      itemsService.addItem('1', 'name', 1);
      expect(itemsService.items, isA<List<CartItem>>());
      final result = itemsService.items[0].id == '1';
      expect(result, true);
    });

    /// test remove Item Method
    test('give item service when call removeItem then remove item', () {
      // Arrange : define items
      itemsService.setItems = items;
      // Act : remmove item where id == 1
      itemsService.removeItem('1');
      final falseResult = itemsService.items[0].id == '1';
      final trueResult = itemsService.items[0].id == '2';

      // Assertion
      expect(falseResult, false);
      expect(trueResult, true);
      expect(itemsService.items.length, 1);
    });

    /// test calculate total Method
    test(
      'give item service when call calculate total then return total amount',
      () {
        // Arrange : define items
        itemsService.setItems = items;
        // Act : calculate total
        final result = itemsService.totalAmount;
        expect(result.round(), 3600);
      },
    );
  });

  //
  group('edge test case', () {
    test(
      'give item service when call calculate total with empty cart then return 0',
      () {
        itemsService.setItems = [
          CartItem(id: '0', name: '', price: 0, quantity: 0),
        ];
        // Act : calculate total
        final result = itemsService.totalAmount;
        expect(result, 0);
      },
    );
    test(
      'give item service when call  %100 discount with  cart then return 0',
      () {
        itemsService.setItems = [
          CartItem(id: '0', name: '', price: 1000, quantity: 1, discount: 1),
        ];
        // Act : calculate total
        final result = itemsService.totalAmount;
        expect(result, 0);
      },
    );
    test(
      'give item service when call  quantity limit is 0 , -1 then return false',
      () {
        itemsService.setItems = items;
        itemsService.updateQuantity('1', -4);
        // Act : calculate total
        final result = itemsService.items.any((item) => item.id == '1');
        expect(result, false);
      },
    );
  });
}
