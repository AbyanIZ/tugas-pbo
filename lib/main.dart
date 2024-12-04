import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    CartPage(),
    OrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryFilter('All', 'images/burger.jpg', 0),
              _buildCategoryFilter('Makanan', 'images/burger.jpg', 1),
              _buildCategoryFilter('Minuman', 'images/teh.jpg', 2),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'All Food',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return FoodCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(String title, String imagePath, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: ClipRRect(
            child: Image.asset(imagePath, width: 50, height: 50),
            borderRadius: BorderRadius.circular(20),
            )
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset('images/burger.jpg', fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Burger King Medium',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp. 50.000,00',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  CartItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Medium',
                    price: 50,
                    quantity: 1,
                  ),
                  CartItem(
                    imagePath: 'images/teh.jpg',
                    name: 'Teh Botol',
                    price: 40,
                    quantity: 2,
                  ),
                  CartItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Small',
                    price: 35,
                    quantity: 1,
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  SummaryRow(label: 'PPN 11%', value: 10),
                  SummaryRow(label: 'Total Belanja', value: 94),
                  Divider(),
                  SummaryRow(
                    label: 'Total Pembayaran',
                    value: 104,
                    isBold: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//CartItem

class CartItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Rp. ${price.toString()}.000,00',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
              ),
              Text('$quantity'),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final int value;
  final bool isBold;

  SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            'Rp. $value.000,00',
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              icon: Icon(Icons.add),
              label: Text("Add Data"),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text("Foto", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 4, child: Text("Nama Produk", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 3, child: Text("Harga", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text("Aksi", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  OrderItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Medium',
                    price: 50,
                  ),
                  OrderItem(
                    imagePath: 'images/teh.jpg',
                    name: 'Teh Botol',
                    price: 4,
                  ),
                  OrderItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Small',
                    price: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PesanPage

class PesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              icon: Icon(Icons.add),
              label: Text("Add Data"),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text("Foto", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 4, child: Text("Nama Produk", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 3, child: Text("Harga", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text("Aksi", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  OrderItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Medium',
                    price: 50,
                  ),
                  OrderItem(
                    imagePath: 'images/teh.jpg',
                    name: 'Teh Botol',
                    price: 4,
                  ),
                  OrderItem(
                    imagePath: 'images/burger.jpg',
                    name: 'Burger King Small',
                    price: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;

  OrderItem({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Rp. ${price.toString()}.000,00',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),

          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.delete, color: Colors.red),
              iconSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}