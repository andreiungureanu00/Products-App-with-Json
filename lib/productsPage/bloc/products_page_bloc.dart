import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonget/database/favorite_singleton.dart';
import 'package:jsonget/models/Product.dart';
import 'package:jsonget/productsPage/bloc/products_page_event.dart';
import 'package:jsonget/productsPage/bloc/products_page_state.dart';

class ProductsPageBloc extends Bloc<ProductsPageEvent, ProductsPageState> {
  int offset = 0, limit = 10;
  List<Product> productList = [];

  @override
  ProductsPageState get initialState => ProductsInit();

  _getProducts() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
        "http://mobile-test.devebs.net:5000/products?limit=$limit&offset=$offset");

    for (var i in response.data) {
      Product product = Product(i["id"], i["title"], i["short_description"],
          i["image"], i["price"], i["details"], i["sale_precent"], false);
      productList.add(product);
    }
    offset += limit;
    productList = await FavouriteSingleton().productsMapToFavourite(productList);
  }

  @override
  Stream<ProductsPageState> mapEventToState(ProductsPageEvent event) async* {
    if (event is LoadProducts) {
      await _getProducts();
      // gives the state of loaded products
      yield ProductsLoaded();
    }
    if(event is ReloadProducts){
      yield ProductsLoaded();
    }
  }

  loadProducts() {
    add(ReloadProducts());
    add(LoadProducts());
  }

  onFavouriteAdded(int productID){
    productList.forEach((element) {
      if(element.id == productID){
        element.isFavourite = true;
        return;
      }
    });
    add(ReloadProducts());
  }

  onFavouriteRemoved(int productID){
    productList.forEach((element) {
      if(element.id == productID){
        element.isFavourite = false;
        return;
      }
    });
    add(ReloadProducts());
  }
}
