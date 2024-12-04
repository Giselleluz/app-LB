import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // Importe o pacote google_fonts
import 'package:provider/provider.dart';
import 'package:tcc_senai/screens/detalhes/detalhes.dart';
import '../componentes/style.dart';
import '../controllers/shopping_cart_controller.dart';
import '../controllers/favorite_controller.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final imagemProduto = productModel.img;
    final overlay = Overlay.of(context);

    // Função para exibir notificação
    void showNotification(String message) {
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Color(0xFFFFD700),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    message,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600, // Peso da fonte ajustado
                      letterSpacing: 0.5, // Espaçamento entre as letras
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);
      Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
    }

    return GestureDetector(
      onTap: () {
        // Navegar para a tela de detalhes do produto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: productModel),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagemProduto,
                  width: 120,
                  height: 100,
                  fit: BoxFit.scaleDown,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 80, color: Colors.red);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productModel.nome, style: AppStyles.productTitle),
                    const SizedBox(height: 4),
                    Text(
                      productModel.descricao,
                      style: AppStyles.productDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'R\$ ${productModel.preco.toStringAsFixed(2)}',
                          style: AppStyles.productPrice,
                        ),
                        const Spacer(),
                        // Ícone de coração para favoritar
                        Consumer<FavoriteController>(
                          builder: (context, favoriteController, _) {
                            final isFavorited = favoriteController.isFavorite(productModel);
                            return IconButton(
                              icon: Icon(
                                isFavorited ? Icons.favorite : Icons.favorite_border,
                                color: isFavorited ? Colors.amber : Colors.grey,
                              ),
                              onPressed: () {
                                favoriteController.toggleFavorite(productModel);
                                showNotification(
                                  isFavorited
                                      ? 'Produto removido dos favoritos'
                                      : 'Produto adicionado aos favoritos',
                                );
                              },
                            );
                          },
                        ),
                        // Ícone de carrinho
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart, color: Colors.grey),
                          onPressed: () {
                            Provider.of<ShoppingCartController>(context, listen: false)
                                .addProduct(productModel);
                            showNotification('Produto adicionado ao carrinho');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
