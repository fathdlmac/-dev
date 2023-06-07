import 'package:flutter/material.dart';
import '../main.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  final Cart cart;

  CartScreen({required this.cart});

  Future<List<Map<String, dynamic>>> _fetchFlowersFromDatabase() async {
    return await DatabaseHelper.instance.getFlowers();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepet'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchFlowersFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                final flowers = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: flowers.length,
                  itemBuilder: (context, index) {
                    final flower = flowers[index];
                    return ListTile(
                      leading: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/rose.jpg',
                        image: flower['image']?? '',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(flower['name']?? ''),
                      subtitle: Text('Toplam: \$${(flower['price'] ?? 0.0).toStringAsFixed(2)}'),
                      trailing: Text('Adet: ${flower['quantity'] ?? 0}'),
                    );
                  },
                );
              }
              return Text('Veritabanından çiçekler alınamadı.');
            },
          ),
          SizedBox(height: 16),
          // Diğer kısımlar...
        ],
      ),
    );
  }
}
