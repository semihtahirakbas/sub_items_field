import 'package:flutter/material.dart';
import 'package:sub_items_field/sub_items_field/sub_items_field.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deneme'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
        child: Column(
          children: [
            SubItemsField<String>(
              onSubmit: (value) {
                debugPrint(value.toMap().toString());
              },
              controller: TextEditingController(),
              label: "Departman Adı",
            )
          ],
        ),
      ),
    );
  }
}
