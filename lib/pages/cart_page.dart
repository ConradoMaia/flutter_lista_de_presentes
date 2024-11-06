import 'package:flutter/material.dart';
import '../models/gift_item.dart';

class CartPage extends StatelessWidget {
  final Map<String, int> cart;
  final List<GiftItem> items;
  final Function(String, int) onUpdateCart;

  const CartPage({
    required this.cart,
    required this.items,
    required this.onUpdateCart,
  });

  @override
  Widget build(BuildContext context) {
    List<GiftItem> cartItems = items.where((item) => cart.containsKey(item.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            final quantity = cart[item.id]!;

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                title: Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text('Quantidade: $quantity'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.redAccent),
                  onPressed: () {
                    onUpdateCart(item.id, 0); // Remove item do carrinho
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
