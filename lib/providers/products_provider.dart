import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toko_app_2/models/http_exception.dart';
import 'package:toko_app_2/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Polo Ralph Lauren Shirt',
    //   description: 'Polo Shirt - it is So cooool!',
    //   price: 150.000 * 2,
    //   imgUrl:
    //       'https://ean-images.booztcdn.com/polo-ralph-lauren/1300x1700/g/raf710548797013_cjamaicaheather_v100180728au.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Jeans UNIQLO',
    //   description: 'Men Slim fit Jeans - a good choice!',
    //   price: 170.000 * 2,
    //   imgUrl:
    //       'https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/433326/sub/goods_433326_sub13.jpg?width=734',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Pantofel Shoes',
    //   description: 'Fordza - A Nice shoes for party!',
    //   price: 280.000 * 2,
    //   imgUrl:
    //       'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//107/MTA-11798369/fordza_sepatu_pantofel_pria_kulit_asli_tali_like_oxford_handmade_fordza_f_077_full02_mnzg0jxr.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Gasper belt',
    //   description:
    //       'Hermes Gasper belt - Look Nice gasper for party or vacation!',
    //   price: 100.000 * 2,
    //   imgUrl:
    //       'https://id-test-11.slatic.net/p/be76e3947ff72e9570c537b61f0fc628.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Rolex',
    //   description: 'Rolex Watch - Elegant!',
    //   price: 800.000 * 3,
    //   imgUrl:
    //       'https://cdn2.chrono24.com/images/uhren/20814237-n1hco1cr3rlwglspxyuu4zsc-ExtraLarge.jpg',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Yamaha MotoGP',
    //   description: 'Yamaha - Cool Drive!',
    //   price: 500.000 * 1000,
    //   imgUrl:
    //       'https://www.naikmotor.com/wp-content/uploads/2021/03/Petronas-SRT-2021-27.jpg',
    // ),
    // Product(
    //   id: 'p7',
    //   title: 'Sajadah Turki',
    //   description: 'Sajadah Turki Asli Bamboo Silk - Comfortable!',
    //   price: 90.000 * 10,
    //   imgUrl:
    //       'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTnibjwJYGpisgLRO2w1HJKSvy_lrtxYrLLflEPYddeJgD39F6OHT5NezUgNVSgTXApXxgI3l1zE6vvWRGB-shyvHiLng4QFAwMP15lu-MR&usqp=CAE',
    // ),
    // Product(
    //   id: 'p8',
    //   title: 'Ferrari 488 GTB Spider ',
    //   description: 'Ferrari 488 GTB Spider Blue - Fast and Drive it!',
    //   price: 200.000 * 10000,
    //   imgUrl: 'https://i.ytimg.com/vi/xi10lxlNb6E/maxresdefault.jpg',
    // ),
    // Product(
    //   id: 'p9',
    //   title: 'Apple MacBook Pro 2022 ',
    //   description: 'Apple M2 Chip - Smooth and Intelligent!',
    //   price: 100.000 * 100,
    //   imgUrl: 'https://cdn.mos.cms.futurecdn.net/bBAQjTGucAnERFdnJU6wdc.jpg',
    // ),
    // Product(
    //   id: 'p10',
    //   title: 'Maserati Silver ',
    //   description: 'Maserati - So Beauty and Fresh Look!',
    //   price: 100.000 * 10000,
    //   imgUrl:
    //       'https://o.aolcdn.com/images/dims3/GLOB/legacy_thumbnail/800x450/format/jpg/quality/85/https://s.yimg.com/os/creatr-uploaded-images/2019-05/2bc88220-7031-11e9-adff-8790306538a2',
    // ),
  ];

  final String authToken;
  final String userId;

  ProductsProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // Method/Function mengambil data and set Product
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/toko-apps-2-default-rtdb-export.json?auth=$authToken&$filterString';
    try {
      // Mengambil data2 produk yg ada di Realtime Firebase
      final response = await http.get(_url);
      //print(json.decode(response.body)); // print(response);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      // Mengecek extractedData
      if (extractedData == null) {
        return;
      }
      _url =
          'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(_url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imgUrl: prodData['imgUrl'],
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // Method AddProduct
  Future<void> addProduct(Product product) async {
    // Http Request ke web server
    final _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/toko-apps-2-default-rtdb-export.json?auth=$authToken';

    try {
      //-------------------------------------
      // menyimpan data ke dalam web server
      //-------------------------------------
      final response = await http.post(
        _url,
        body: json.encode(
          {
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imgUrl': product.imgUrl,
            'creatorId': userId,
            // 'isFavorite': product.isFavorite,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'], // DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imgUrl: product.imgUrl,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
      // mencegah terjadinya crash pd App
    } catch (error) {
      //print(error);
      throw (error);
    }
  }

  // Method/Function Update Product
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final _url =
          'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/toko-apps-2-default-rtdb-export/$id.json?auth=$authToken';
      // mengupdate data yg sudah ada di database
      await http.patch(_url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imgUrl': newProduct.imgUrl,
            'price': newProduct.price,
          }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  // Method/Function delete product
  Future<void> deleteProduct(String id) async {
    final _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/toko-apps-2-default-rtdb-export/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    // mendelete data yg sudah ada di database
    final response = await http.delete(_url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Tidak bisa menghapus produk');
    }
    existingProduct = null;
  }
}
