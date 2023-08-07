import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app_2/providers/auth.dart';
import 'package:toko_app_2/providers/cart.dart';
import 'package:toko_app_2/screens/product_detail_screen.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          //---------------
          // Image Produk
          //---------------
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          //---------------------------------
          // Nama Produk, love, & keranjang
          //---------------------------------
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              // Love active
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus(
                  authData.token,
                  authData.userId,
                );
              },
              color: Theme.of(context).accentColor,
            ),
            //--------------
            // nama barang
            //--------------
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            //-------------------------------
            // Keranjang (onClick snackbar)
            //-------------------------------
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                  product.id,
                  product.title,
                  product.price,
                );
                //----------------------------
                // onClick UNDO with snackbar
                //----------------------------
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Menambah item ke keranjang!',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
