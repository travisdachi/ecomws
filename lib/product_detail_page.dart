import 'package:async_redux/async_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomws/actions.dart';
import 'package:ecomws/cart_page.dart';
import 'package:ecomws/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = false;
  String productDetail;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    setState(() {
      isLoading = true;
    });
    final response = await getProductDetail();
    setState(() {
      productDetail = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              centerTitle: true,
              title: Text(widget.product.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    constraints: BoxConstraints.expand(),
                    color: Colors.white,
                    child: CachedNetworkImage(imageUrl: widget.product.imageUrl),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.3, 0.7, 1.0],
                        colors: <Color>[
                          Colors.black38,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black38,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            minimum: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                if (isLoading) Center(child: CircularProgressIndicator()),
                if (!isLoading) ...[
                  Text(
                    productDetail,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Builder(builder: (context) {
                    return RaisedButton(
                      child: Text('Add to cart (${MaterialLocalizations.of(context).formatDecimal(widget.product.price.toInt())}THB)'),
                      onPressed: () {
                        Provider.of<Dispatch>(context)(AddToCartAction(widget.product));
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('${widget.product.name} added!'),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'View Cart',
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getProductDetail() async {
  await Future.delayed(Duration(milliseconds: 500));
  return '''
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet risus feugiat in ante metus dictum at tempor. Commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae. Nulla aliquet porttitor lacus luctus. Sit amet massa vitae tortor condimentum. Aenean euismod elementum nisi quis eleifend quam adipiscing vitae proin. Adipiscing bibendum est ultricies integer quis auctor elit sed vulputate. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Amet cursus sit amet dictum sit amet justo donec enim. Amet dictum sit amet justo donec enim diam vulputate. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Amet consectetur adipiscing elit ut aliquam purus sit.

Sed adipiscing diam donec adipiscing tristique. Sit amet consectetur adipiscing elit ut. Tellus integer feugiat scelerisque varius morbi. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam. Nisi vitae suscipit tellus mauris a diam. Sed libero enim sed faucibus turpis in eu mi. Risus pretium quam vulputate dignissim suspendisse in est ante. Dictum sit amet justo donec enim diam. Sit amet venenatis urna cursus eget nunc scelerisque viverra. Vitae justo eget magna fermentum. Ridiculus mus mauris vitae ultricies leo integer.

Maecenas ultricies mi eget mauris. Ut tortor pretium viverra suspendisse potenti nullam. Porta lorem mollis aliquam ut porttitor leo. Lobortis feugiat vivamus at augue eget arcu dictum. Scelerisque in dictum non consectetur a. Vel pharetra vel turpis nunc. Commodo elit at imperdiet dui accumsan sit amet. Fringilla phasellus faucibus scelerisque eleifend donec. A cras semper auctor neque vitae tempus. Sapien eget mi proin sed libero enim sed faucibus turpis. Quisque non tellus orci ac auctor augue mauris augue neque.''';
}
