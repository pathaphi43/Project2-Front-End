import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final cartBloc = BlocProvider.of<CartBloc>(context);
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        )
      ],
    );
  }
}
