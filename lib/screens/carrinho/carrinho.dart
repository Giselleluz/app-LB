import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/screens/cardapio/cardapio.dart';
import 'package:tcc_senai/screens/pagamento/pagamento.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Estado para rastrear qual opção está selecionada
  bool isDeliverySelected = true;

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ShoppingCartController>(context);
    final cartItems = cartController.items;
    final total = cartController.totalPrice + 6.0; // Taxa de entrega fixa (R$6,00)

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text('Seu carrinho', style: AppStyles.titlePage),
              linha(180),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0), // Espaço para a navbar flutuante
        child: Column(
          children: [
            // Botões de opções: Delivery ou Peça e Retire
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDeliveryOptionButton(
                    'Delivery',
                    isDeliverySelected,
                    () => _toggleDeliveryOption(true),
                  ),
                  const SizedBox(width: 8),
                  _buildDeliveryOptionButton(
                    'Peça e Retire',
                    !isDeliverySelected,
                    () => _toggleDeliveryOption(false),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Lista de itens no carrinho
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems[index];
                  final quantity = cartController.getQuantity(product);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        // Imagem do produto
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.img,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Detalhes do produto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.nome,
                                style: AppStyles.productTitle,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'R\$${product.preco.toStringAsFixed(2)}',
                                style: AppStyles.NormalText,
                              ),
                            ],
                          ),
                        ),
                        // Botões de quantidade
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.black),
                              onPressed: () {
                                cartController.removeProduct(product);
                              },
                            ),
                            Text(
                              '$quantity',
                              style: AppStyles.NormalText,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.black),
                              onPressed: () {
                                cartController.addProduct(product);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            // Total e Taxa de Entrega
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalRow('Total:', 'R\$${cartController.totalPrice.toStringAsFixed(2)}'),
                  const SizedBox(height: 4),
                  _buildTotalRow('Taxa de entrega:', 'R\$6,00'),
                  const Divider(),
                ],
              ),
            ),
            // Botões de Adicionar Mais Itens e Continuar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                      ),
                      child: Text(
                        'Adicionar',
                        style: AppStyles.productTitle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PayPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                      ),
                      child: Text(
                        'Continuar',
                        style: AppStyles.productTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDeliveryOption(bool isDelivery) {
    setState(() {
      isDeliverySelected = isDelivery;
    });
  }

  Widget _buildDeliveryOptionButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFFFD700) : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: AppStyles.productTitle,
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyles.NormalText),
        Text(value, style: AppStyles.productTitle),
      ],
    );
  }
}
