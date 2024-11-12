import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/gift_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<GiftItem> _cartItems = [];

  Future<void> loadCartItems() async {
    final items = await DatabaseHelper.instance.fetchAllGiftItems();
    setState(() {
      _cartItems = items;
    });
  }

  void removeItemFromCart(int id) async {
    await DatabaseHelper.instance.deleteGiftItem(id);
    loadCartItems(); // Recarrega os itens do carrinho após remover
  }

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
      body: _cartItems.isEmpty
          ? Center(child: Text('Seu carrinho está vazio'))
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final item = _cartItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.price != null ? 'R\$ ${item.price!.toStringAsFixed(2)}' : ''),
                IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    removeItemFromCart(item.id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
