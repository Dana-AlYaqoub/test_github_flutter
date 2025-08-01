import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // List to hold shopping items and their quantities
  List<Map<String, String>> shoppingList = [];

  // Controllers for the text fields
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // Function to add an item to the list
  void _addItem() {
    if (_itemController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
      setState(() {
        shoppingList.add({
          'item': _itemController.text,
          'quantity': _quantityController.text,
        });
      });
      _itemController.clear();
      _quantityController.clear();
    }
  }

  // Function to show dialog for deleting an item
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: const Text("Do you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  shoppingList.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row to align the item name and quantity TextField horizontally
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      labelText: 'Type the item here',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Type the quantity here',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Show the list if it's not empty
            shoppingList.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${index + 1}: ${shoppingList[index]['item']}"),
                    trailing: Text("quantity: ${shoppingList[index]['quantity']}"),
                    onLongPress: () => _showDeleteDialog(index),
                  );
                },
              ),
            )
                : const Text("There are no items in the list"),
          ],
        ),
      ),
    );
  }
}
