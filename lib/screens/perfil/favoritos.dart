import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/favorite_controller.dart';
import 'package:tcc_senai/componentes/product_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteController = Provider.of<FavoriteController>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Adicionando título e linha decorativa
          Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text('Favoritos', style: AppStyles.titlePage),
                linha(300),
                const SizedBox(height: 24),
              ],
            ),
          ),
          // Exibição da lista de favoritos ou mensagem caso esteja vazia
          favoriteController.favorites.isEmpty
              ? const Center(
                  child: Text('Nenhum produto favoritado.'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: favoriteController.favorites.length,
                    itemBuilder: (context, index) {
                      final product = favoriteController.favorites[index];
                      return ProductCard(productModel: product);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
