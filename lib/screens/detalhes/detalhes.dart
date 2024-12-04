import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ShoppingCartController>(context);
    final overlay = Overlay.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Fundo arredondado com cor amarela
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700), // Cor amarela
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(100), // Arredondamento apenas na parte inferior
              ),
            ),
            height: 320, // Altura ajustada do fundo amarelo
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão de voltar e imagem do produto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.network(
                  product.img,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 60),

              // Detalhes do produto
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Nome, categoria e preço
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.nome,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.categoria,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "R\$ ${product.preco.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Descrição
                      Text(
                        product.descricao,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: const Color(0xff555555),
                        ),
                      ),
                      const Spacer(),

                      // Controle de quantidade e botão "Adicionar"
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            // Controle de quantidade
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Botão de remover com borda
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove),
                                      color: Colors.black,
                                      onPressed: () {
                                        cartController.removeProduct(product);
                                      },
                                    ),
                                  ),
                                  // Quantidade exibida
                                  Text(
                                    cartController.getQuantity(product).toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Botão de adicionar com borda
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      color: Colors.black,
                                      onPressed: () {
                                        cartController.addProduct(product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Botão "Adicionar" com notificação personalizada
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFD700),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  cartController.addProduct(product);

                                  // Notificação personalizada
                                  final overlayEntry = OverlayEntry(
                                    builder: (context) => Positioned(
                                      top: MediaQuery.of(context).padding.top + 10,
                                      left: 0,
                                      right: 0,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 16),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 16),
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
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle,
                                                    color:  Color(0xFFFFD700),
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Item adicionado ao carrinho',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  overlay.insert(overlayEntry);
                                  Future.delayed(const Duration(seconds: 3),
                                      () => overlayEntry.remove());
                                },
                                child: Text(
                                  "Adicionar R\$ ${(cartController.getQuantity(product) * product.preco).toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
