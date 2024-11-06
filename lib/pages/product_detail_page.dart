import 'package:flutter/material.dart';
import '../models/gift_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final GiftItem item;
  final Function(String, int) onUpdateCart;
  final int cartQuantity;

  const ProductDetailPage({
    required this.item,
    required this.onUpdateCart,
    required this.cartQuantity,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name, style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cart: {widget.item.id: widget.cartQuantity},
                    items: [widget.item],
                    onUpdateCart: widget.onUpdateCart,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.item.imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(widget.item.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              'Quantidade disponível: ${widget.item.totalQuantity - widget.item.selectedQuantity}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Selecionar quantidade:', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedQuantity,
                  items: List.generate(
                    (widget.item.totalQuantity - widget.item.selectedQuantity) + 1,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedQuantity = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _openPurchaseLink(widget.item.link),
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Visitar link'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: widget.item.isAvailable
                      ? () {
                    setState(() {
                      widget.onUpdateCart(widget.item.id, selectedQuantity);
                    });
                  }
                      : null,
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text('Adicionar ao Carrinho'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
            if (widget.cartQuantity > 0)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'No carrinho: ${widget.cartQuantity}',
                  style: TextStyle(fontSize: 16, color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openPurchaseLink(String link) async {
    final Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not open $link';
    }
  }
}
