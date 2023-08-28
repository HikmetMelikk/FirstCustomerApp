import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Page'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: const Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Hero(
                tag: 'products',
                child: Material(
                  child: Text(
                    'Products Page',
                    style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
