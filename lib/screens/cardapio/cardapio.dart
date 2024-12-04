import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/CircularProgressIndicator.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/product_controller.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/model/product_model.dart';
import 'package:tcc_senai/componentes/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController _productController = ProductController();
  String selectedCategory = "Carne";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ShoppingCartController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text('Menu', style: AppStyles.titlePage),
              linha(180),
            ],
          ),
        ),
        
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
         Padding(
  padding: const EdgeInsets.all(16.0),
  child: SizedBox(
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), // Arredondamento suave
        color: const Color.fromARGB(255, 236, 233, 233), // Fundo do campo de texto
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8, // O campo de texto ocupa 80% do espaço
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                onChanged: (value) {
                  // Lógica de busca ao digitar no campo
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Pesquisar...', // Placeholder do campo
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    borderSide: BorderSide.none, // Sem borda externa
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 60, // Botão de busca com tamanho fixo
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xffFDD741), // Cor do botão amarelo
              shape: BoxShape.circle, // Formato circular
            ),
            child: IconButton(
              onPressed: () {
                // Ação ao clicar no botão de busca
                debugPrint('Buscando por: $searchQuery');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black, // Cor do ícone
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),
          const SizedBox(height: 16),
          if (searchQuery.isEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Carne",
                    "Frango",
                    "Vegetariano",
                    "Acompanhamento",
                    "Bebidas",
                    "Sobremesas"
                  ].map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCategory == category
                              ? const Color(0xFFFFD700)
                              : const Color.fromARGB(255, 236, 233, 233),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
              future: _productController.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: RotatingLogo(),);
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum produto disponível.'));
                }

                List<ProductModel> filteredProducts;

                if (searchQuery.isNotEmpty) {
                  filteredProducts = snapshot.data!
                      .where((product) =>
                          product.nome.toLowerCase().contains(searchQuery))
                      .toList();
                } else {
                  filteredProducts = snapshot.data!
                      .where((product) =>
                          product.categoria == selectedCategory)
                      .toList();
                }

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text("Nenhum produto encontrado."),
                  );
                }
              
                return ListView.builder(
                  itemCount: filteredProducts.length,

                  itemBuilder: (context, index) {
                    return ProductCard(productModel: filteredProducts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
