import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/gift_item.dart';

class ProductRegistrationPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _imagePath;

  void saveGiftItem(BuildContext context) async {
    final item = GiftItem(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text),
      imagePath: _imagePath,
    );

    await DatabaseHelper.instance.insertGiftItem(item);
    Navigator.pop(context); // Retorna à tela anterior após salvar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => saveGiftItem(context),
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
