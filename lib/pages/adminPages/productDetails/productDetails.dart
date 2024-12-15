import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:
                Text('Product Details', style: CustomeTextStyle.txtWhiteBold),
            backgroundColor: Colors.black,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[const Text('Product Details')],
            ),
          ),
        ));
  }
}
