import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:toko_app_2/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  // Function Mengambil data & Set Orders di Realtime Database
  Future<void> fetchAndSetOrders() async {
    // Http Request ke web server
    final _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/Orders/$userId.json?auth=$authToken';
    // Mengambil data2 orders yg ada di Realtime Firebase
    final response = await http.get(_url);
    // print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    // Mengecek extractedData
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity']),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  // Method/Function addOrder
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    // Http Request ke web server
    final _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/Orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();

    // menyimpan data ke dalam web server
    final response = await http.post(
      _url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList(),
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
