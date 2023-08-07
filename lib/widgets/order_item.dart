import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toko_app_2/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          //-----------------------------------------------------------
          // Jumlah Rp yg dipesan & Waktu, Tgl, bulan, tahun pemesanan
          //-----------------------------------------------------------
          ListTile(
            title: Text(
              '\Rp.${widget.order.amount.toStringAsFixed(3)}',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),
              style: const TextStyle(
                color: Colors.orange,
              ),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            //------------------
            // Ukuran Container
            //------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              //------------------------------------
              // Rincian item-item yg telah dipesan
              //------------------------------------
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //--------------------------
                          // nama-nama barang pesanan
                          //--------------------------
                          Text(
                            prod.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                          //----------------------
                          // Harga-harga pesanan
                          //----------------------
                          Text(
                            '${prod.quantity}x \Rp.${prod.price.toStringAsFixed(3)},-',
                            style: const TextStyle(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 40, 245, 47),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
