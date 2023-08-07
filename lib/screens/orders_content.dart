import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app_2/providers/orders.dart' show Orders;
import 'package:toko_app_2/widgets/app_drawer.dart';
import 'package:toko_app_2/widgets/order_item.dart';

class OrdersContent extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersContent> createState() => _OrdersContentState();
}

class _OrdersContentState extends State<OrdersContent> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Anda'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const LinearProgressIndicator()
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, i) => OrderItem(orderData.orders[i])),
    );
  }
}
