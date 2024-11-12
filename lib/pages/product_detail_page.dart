import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/gift_item.dart';

class ProductDetailPage extends StatelessWidget {
  final GiftItem item;

  ProductDetailPage({required this.item});

  Future<void> addItemToCart(BuildContext context) async {
    await DatabaseHelper.instance.insertGiftItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} foi adicionado ao carrinho')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          item.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.cyan[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
                image: item.imagePath != null
                    ? DecorationImage(
                  image: AssetImage(item.imagePath!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: item.imagePath == null
                  ? Icon(
                Icons.image,
                size: 80,
                color: Colors.grey[500],
              )
                  : null,
            ),
            SizedBox(height: 24),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              item.description ?? 'Nenhuma descrição disponível.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.price != null
                      ? 'R\$ ${item.price!.toStringAsFixed(2)}'
                      : 'Preço indisponível',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[700],
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.add_shopping_cart, size: 28),
                label: Text(
                  'Adicionar ao Carrinho',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  addItemToCart(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.cyan[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
