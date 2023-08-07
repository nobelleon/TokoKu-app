import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app_2/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  );

  @override
  Widget build(BuildContext context) {
    //---------------
    // Delete item
    //---------------
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 39,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      //------------------------------------------
      // Konfirmasi (dialog) item di hapus/tidak
      //------------------------------------------
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Anda yakin?'),
            content: const Text('Anda ingin menghapus item dari keranjang?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Ya'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          //-------------------------------------------------------------
          // Hasil pesanan berupa img, Nama barang, Harga & jml barang
          //-------------------------------------------------------------
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\Rp.$price'),
                ),
              ),
            ),
            //-------------
            // Nama barang
            //-------------
            title: Text(title),
            //---------------------------------
            // Harga Barang yg dipesan (biaya)
            //---------------------------------
            subtitle:
                Text('Total: \Rp.${(price * quantity).toStringAsFixed(3)},-'),
            //--------------------------
            // Jumlah barang yg dibeli
            //--------------------------
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
