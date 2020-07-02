import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonget/database/favorite_singleton.dart';
import 'package:jsonget/models/Product.dart';

class ProductInfoWidgetCell extends StatefulWidget {
  final Product product;

  ProductInfoWidgetCell(this.product);

  @override
  ProductInfoWidgetCellState createState() => ProductInfoWidgetCellState();
}

class ProductInfoWidgetCellState extends State<ProductInfoWidgetCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
          child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 35,
                      width: 400,
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                      child: InkWell(
                        child: Icon(
                          Icons.favorite,
                          size: 24.0,
                          color: widget.product.isFavourite
                              ? Colors.red
                              : Colors.black26,
                        ),
                        onTap: () {
                          FavouriteSingleton()
                              .addToFavourite(widget.product);
                          print(FavouriteSingleton().getProductsList());
                        },
                      )),
                ],
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 250,
                  width: 330,
                  child: new Image.network(widget.product.imageUrl),
                ),
              ),
              InkWell(
                child: Container(
                  height: 50,
                  width: 400,
                  margin: EdgeInsets.only(top: 24),
                  child: Center(
                    child: new Text(
                      widget.product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000066),
                          fontSize: 22),
                    ),
                  ),
                ),
              ),
              Container(
                height: 35,
                width: 400,
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    widget.product.short_description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'RobotMono',
                    ),
                  ),
                ),
              ),
              Container(
                height: 35,
                width: 400,
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.sale_precent > 0
                            ? (widget.product.price *
                                        (100 - widget.product.sale_precent) ~/
                                        100)
                                    .toString() +
                                '€'
                            : " ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff0101DF),
                            fontSize: 23,
                            fontFamily: 'RobotMono'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.product.price.toString() + '€',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: widget.product.sale_precent > 0
                                ? Color(0xff7F7F7F)
                                : Color(0xff0101DF),
                            decoration: widget.product.sale_precent > 0
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: widget.product.sale_precent > 0 ? 18 : 23,
                            fontFamily: 'RobotMono'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 400,
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            widget.product.details,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}