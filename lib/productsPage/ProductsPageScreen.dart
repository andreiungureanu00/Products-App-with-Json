// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonget/cells/product_widget_cell.dart';
import 'package:jsonget/database/favorite_singleton.dart';
import 'package:jsonget/favourites/favourites_screen.dart';
import 'package:jsonget/productsPage/bloc/products_page_bloc.dart';
import 'package:jsonget/productsPage/bloc/products_page_state.dart';

class ProductsPageScreen extends StatefulWidget {
  ProductsPageScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsPageScreenState createState() => _ProductsPageScreenState();
}

class _ProductsPageScreenState extends State<ProductsPageScreen>
    with FavouriteEvents {
  ScrollController controller;
  ProductsPageBloc _bloc;
  bool isSignInGoogle = false;
  bool isSignInFacebook = false;

  @override
  void initState() {
    _bloc = ProductsPageBloc();
    controller = new ScrollController();

    // initial load
    _bloc.loadProducts();
    FavouriteSingleton().addListener(this);
    super.initState();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        _bloc.loadProducts();
      }
    });
  }

  void dispose() {
    controller.dispose();
    FavouriteSingleton().removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/productBackground.jfif'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text("Online Shop"),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FavouritesPageScreen(),
                      ));
                    }
                  },
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            BlocBuilder<ProductsPageBloc, ProductsPageState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (_bloc.productList != null) {
                    return Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: _bloc.productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductWidgetCell(_bloc.productList[index]);
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  void onFavouriteAdded(int productId) {
    _bloc.onFavouriteAdded(productId);
  }

  @override
  void onFavouriteDeleted(int productId) {
    _bloc.onFavouriteRemoved(productId);
  }
}
