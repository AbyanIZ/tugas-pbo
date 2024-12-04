import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductFormPage(),
    );
  }
}

class ProductFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back and Profile Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.red),
                    onPressed: () {
                     Navigator.pop(context); // Action for back button
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.black),
                    onPressed: () {
                      // Action for profile button
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Nama Produk
              buildTextField("Nama Produk", "Masukan nama produk"),
              SizedBox(height: 20),

              // Harga
              buildTextField("Harga", "Masukan Harga"),
              SizedBox(height: 20),

              // Kategori Produk Dropdown
              buildDropdownField("Kategori produk", "Makanan"),
              SizedBox(height: 20),

              // Image Upload
              buildTextField("Image", "Choose file"),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Action for submit button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .blue, // Mengganti 'primary' dengan 'backgroundColor'
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField(String label, String selectedItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) {
              // Action when item is selected
            },
            items: ["Makanan", "Minuman", "Lainnya"].map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}