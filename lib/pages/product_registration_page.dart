import 'package:flutter/material.dart';
import '../models/gift_item.dart';

class ProductRegistrationPage extends StatefulWidget {
  final Function(GiftItem) onAddItem;

  const ProductRegistrationPage({Key? key, required this.onAddItem}) : super(key: key);

  @override
  _ProductRegistrationPageState createState() => _ProductRegistrationPageState();
}

class _ProductRegistrationPageState extends State<ProductRegistrationPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _linkController = TextEditingController();

  void _saveProduct() {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final link = _linkController.text;

    if (name.isNotEmpty && quantity > 0) {
      final newItem = GiftItem(
        id: DateTime.now().toString(),
        name: name,
        description: description,
        imageUrl: 'assets/images/placeholder.png', // Imagem padrão
        link: link,
        totalQuantity: quantity,
        selectedQuantity: 0,
      );

      widget.onAddItem(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantidade Total'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Link do Produto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
