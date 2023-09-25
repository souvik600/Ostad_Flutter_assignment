import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 7 Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product("Product 1", 10.0, 0),
    Product("Product 2", 20.0, 0),
    Product("Product 3", 30.0, 0),
    Product("Product 4", 10.0, 0),
    Product("Product 5", 20.0, 0),
    Product("Product 6", 30.0, 0),
    Product("Product 7", 10.0, 0),
    Product("Product 8", 20.0, 0),
    Product("Product 8", 30.0, 0),
    Product("Product 10", 10.0, 0),
    Product("Product 11", 20.0, 0),
    Product("Product 12", 30.0, 0),
  ];

  void _incrementQuantity(int index) {
    setState(() {
      products[index].quantity++;
      if (products[index].quantity == 5) {
        _showCongratulationsDialog(products[index].name);
      }
    });
  }

  void _showCongratulationsDialog(String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You've bought 5 $productName!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Product List")),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Count: ${products[index].quantity}"),
                  ElevatedButton(
                    onPressed: () {
                      _incrementQuantity(index);
                    },
                    child: Text("Buy Now"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),

      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  int getTotalQuantity() {
    int totalQuantity = 0;
    for (var product in products) {
      totalQuantity += product.quantity;
    }
    return totalQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Cart")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Products:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              getTotalQuantity().toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
