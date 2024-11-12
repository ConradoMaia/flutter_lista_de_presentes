import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/gift_item.dart';
import 'cart_page.dart';
import 'product_registration_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GiftItem> _giftItems = [];

  Future<void> loadGiftItems() async {
    final items = await DatabaseHelper.instance.fetchAllGiftItems();
    setState(() {
      _giftItems = items;
    });
  }

  Future<void> addItemToCart(GiftItem item) async {
    await DatabaseHelper.instance.insertGiftItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} foi adicionado ao carrinho')),
    );
  }

  @override
  void initState() {
    super.initState();
    loadGiftItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Lista de Presentes', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductRegistrationPage()),
              ).then((_) => loadGiftItems());
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.cyan[700],
        elevation: 4,
      ),
      body: _giftItems.isEmpty
          ? Center(child: Text('Nenhum presente disponível', style: TextStyle(fontSize: 20, color: Colors.grey[600])))
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: _giftItems.length,
        itemBuilder: (context, index) {
          final item = _giftItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(item: item),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: item.imagePath != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        item.imagePath!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.description ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      item.price != null
                          ? 'R\$ ${item.price!.toStringAsFixed(2)}'
                          : 'Preço indisponível',
                      style: TextStyle(
                        color: Colors.cyan[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text('Adicionar'),
                      onPressed: () {
                        addItemToCart(item);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 36),
                        backgroundColor: Colors.cyan[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
