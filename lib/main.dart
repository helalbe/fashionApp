import 'package:flutter/material.dart';

void main() {
  runApp(const FashionApp());
}

//////////////////////////////////////////////////////
// 🧱 Model
//////////////////////////////////////////////////////

class Item {
  final String title;
  final double price;
  final String image;

  Item({required this.title, required this.price, required this.image});
}

//////////////////////////////////////////////////////
// 🚀 App
//////////////////////////////////////////////////////

class FashionApp extends StatelessWidget {
  const FashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fashion Store",
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

//////////////////////////////////////////////////////
// 🏠 Main Screen
//////////////////////////////////////////////////////

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fashion Store")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.checkroom, size: 80, color: Colors.white),
              const SizedBox(height: 20),

              const Text(
                "Welcome to Fashion World",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ItemListScreen(),
                    ),
                  );
                },
                child: const Text("View Items"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
// 🛍️ Items Screen
//////////////////////////////////////////////////////

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final List<Item> items = [
    Item(
      title: "T-Shirt",
      price: 25,
      image:
      "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
    ),
    Item(
      title: "Sneakers",
      price: 90,
      image:
      "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
    ),
    Item(
      title: "Jacket",
      price: 120,
      image:
      "https://images.unsplash.com/photo-1521335629791-ce4aec67dd47",
    ),
  ];

  final List<Item> saved = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedScreen(saved: saved),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(items[index].image, width: 60),
              title: Text(items[index].title),
              subtitle: Text("\$${items[index].price}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ItemDetailsScreen(item: items[index]),
                  ),
                );

                if (result != null) {
                  setState(() {
                    if (!saved.contains(items[index])) {
                      saved.add(items[index]);
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////
// 📄 Details Screen
//////////////////////////////////////////////////////

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(item.image, height: 200),
            const SizedBox(height: 20),

            Text(
              item.title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              "\$${item.price}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Item saved successfully ✅");
              },
              child: const Text("Save Item"),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////
// ⭐ Saved Screen
//////////////////////////////////////////////////////

class SavedScreen extends StatelessWidget {
  final List<Item> saved;

  const SavedScreen({super.key, required this.saved});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Items")),
      body: saved.isEmpty
          ? const Center(child: Text("No items saved"))
          : ListView.builder(
        itemCount: saved.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(saved[index].title),
            subtitle: Text("\$${saved[index].price}"),
          );
        },
      ),
    );
  }
}