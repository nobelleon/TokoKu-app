import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app_2/providers/auth.dart';
import 'package:toko_app_2/providers/cart.dart';
import 'package:toko_app_2/providers/orders.dart';
import 'package:toko_app_2/providers/products_provider.dart';
import 'package:toko_app_2/screens/auth_screen.dart';
import 'package:toko_app_2/screens/cart_contents.dart';
import 'package:toko_app_2/screens/edit_product_content.dart';
import 'package:toko_app_2/screens/orders_content.dart';
import 'package:toko_app_2/screens/product_detail_screen.dart';
import 'package:toko_app_2/screens/products_overview_screen.dart';
import 'package:toko_app_2/screens/splash_screen.dart';
import 'package:toko_app_2/screens/user_products_content.dart';

import 'widgets/peta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //-------------------------------------
    // 2 Provider ProductsProvider & Cart
    //-------------------------------------
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Toko App 2',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              fontFamily: 'Poppins'),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            // Detail Barang
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            // Isi Keranjang
            CartContents.routeName: (context) => CartContents(),
            // Pesanan Anda (Drawer : Barang Pesanan)
            OrdersContent.routeName: (context) => OrdersContent(),
            // Produk Anda (Drawer: Atur Produk)
            UserProductsContent.routeName: (context) => UserProductsContent(),
            // Tambah Produk + (Drawer: Atur Produk)
            EditProductContent.routeName: (context) => EditProductContent(),
            Peta.routeName: (context) => Peta(),
          },
        ),
      ),
    );
  }
}
