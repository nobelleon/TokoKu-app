import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:toko_app_2/providers/cart.dart';
import 'package:toko_app_2/providers/products_provider.dart';
import 'package:toko_app_2/screens/CallScreen/call_screen.dart';
import 'package:toko_app_2/screens/VideoCallScreen/videocall_screen.dart';
import 'package:toko_app_2/screens/cart_contents.dart';
import 'package:toko_app_2/widgets/app_drawer.dart';
import 'package:toko_app_2/widgets/badge.dart';
import 'package:toko_app_2/widgets/products_grid.dart';

import '../widgets/badges.dart';
import '../widgets/peta.dart';

enum FilterOptions {
  Favorites,
  All,
  Call,
  VideoCall,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokoKu'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              FeatherIcons.mapPin,
              size: 23,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Peta.routeName);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const Peta();
              //     },
              //   ),
              // );
            },
          ),
          //---------------------
          // Keranjang Top Bar
          //---------------------
          Consumer<Cart>(
            builder: (_, cart, ch) => Badges(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartContents.routeName);
              },
            ),
          ),
          //-----------------
          // Tombol More vert
          //-----------------
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CallScreen();
                          },
                        ),
                      );
                    },
                    child: const Text('Call')),
                value: FilterOptions.Call,
              ),
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const VideoCallScreen();
                          },
                        ),
                      );
                    },
                    child: Text('Video Call')),
                value: FilterOptions.VideoCall,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const LinearProgressIndicator()
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
