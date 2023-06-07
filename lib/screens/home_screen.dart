import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/flower.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Flower> flowers = [
    Flower(
      name: 'Gül',
      price: 25.0,
      imageUrl: 'assets/images/rose.jpg',
    ),
    Flower(
      name: 'Lale',
      price: 20.0,
      imageUrl: 'assets/images/tulip.jpg',
    ),
    Flower(
      name: 'Orkide',
      price: 30.0,
      imageUrl: 'assets/images/orchid.jpg',
    ),
  ];

  final Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çiçek Dükkanı'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: flowers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              flowers[index].imageUrl,
              width: 50,
              height: 50,
            ),
            title: Text(flowers[index].name),
            subtitle: Text('\$${flowers[index].price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                final cart = Cart();
                cart.addItem(CartItem(flower: flowers[index]));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Çiçek sepete eklendi!'),
                    duration: Duration(seconds: 2),
                  )
                );
              }
            ),  
          );
        },
      ),
    );
  }
}
