import 'package:flutter/material.dart';
import 'package:flutter_lista_de_presentes/pages/product_registration_page.dart';
import '../models/gift_item.dart';
import 'product_detail_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GiftItem> items = [
    GiftItem(
      id: '1',
      name: 'Conjunto de Panelas',
      description: 'Panelas de inox com antiaderente',
      imageUrl: 'images/placeholder.png', // Imagem local
      link: 'https://linkparacompra.com',
      totalQuantity: 5,
    ),
    GiftItem(
      id: '2',
      name: 'Jogo de Toalhas',
      description: 'Toalhas de algodão de alta qualidade',
      imageUrl: 'images/placeholder.png', // Imagem local
      link: 'https://linkparacompra.com',
      totalQuantity: 3,
    ),
  ];

  Map<String, int> cart = {};

  void updateCart(String itemId, int quantity) {
    setState(() {
      if (quantity > 0) {
        cart[itemId] = quantity;
      } else {
        cart.remove(itemId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Presentes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart, items: items, onUpdateCart: updateCart),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductRegistrationPage(onAddItem: (GiftItem ) {  },),
                ),
              );
            },
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                title: Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.description, style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 5),
                    Text(
                      'Disponíveis: ${item.totalQuantity - item.selectedQuantity} de ${item.totalQuantity}',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ],
                ),
                trailing: Icon(
                  item.isAvailable ? Icons.check_circle : Icons.cancel,
                  color: item.isAvailable ? Colors.green : Colors.red,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      item: item,
                      onUpdateCart: updateCart,
                      cartQuantity: cart[item.id] ?? 0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
