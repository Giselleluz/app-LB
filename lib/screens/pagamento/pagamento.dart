import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/screens/pagamento/confirmacao.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  String selectedPaymentMethod = '';
  String? selectedAddress = 'Rua Ari Barroso, 305, Osasco';
  String? cpfCnpj;

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ShoppingCartController>(context);
    final total = cartController.totalPrice + 6.0; // Taxa de entrega fixa

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text('Detalhes do pedido', style: AppStyles.titlePage),
                        linha(300),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          selectedAddress ?? 'Selecione um endereço',
                          style: AppStyles.productTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: _showAddressDialog,
                        child: Text(
                          'Alterar',
                          style: AppStyles.productTitleGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CPF/CNPJ na nota',
                        style: AppStyles.productTitle,
                      ),
                      TextButton(
                        onPressed: _showCpfCnpjDialog,
                        child: Text(
                          cpfCnpj == null ? 'Adicionar' : 'Alterar',
                          style: AppStyles.productTitleGrey,
                        ),
                      ),
                    ],
                  ),
                  if (cpfCnpj != null)
                    Align(
                      alignment: Alignment
                          .centerLeft, 
                      child: Text(
                        cpfCnpj!,
                        style: GoogleFonts.poppins(
                          color:  Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const Divider(),
                  const SizedBox(height: 16),

                  // Caixa de resumo ampliada
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow('Subtotal',
                            'R\$ ${cartController.totalPrice.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),
                        _buildSummaryRow('Envio', 'R\$ 6.00'),
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Total',
                          'R\$ ${total.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Formas de pagamento em caixas quadradas
                  Text(
                    'Formas de pagamento:',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPaymentOption('Cartão', Icons.credit_card),
                      const SizedBox(width: 16),
                      _buildPaymentOption('Pix', Icons.pix),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Botão Pagar fixo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: selectedPaymentMethod.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmPage(
                            selectedAddress: selectedAddress ?? '',
                            paymentMethod: selectedPaymentMethod,
                            total: total.toStringAsFixed(2),
                            cpfCnpj: cpfCnpj,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDD741),
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                'Pagar',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog() {
    List<String> addresses = [
      'Rua Ari Barroso, 305, Osasco',
      'Av. Paulista, 1234, São Paulo',
      'Rua das Flores, 567, Campinas'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selecione um endereço', style: AppStyles.productTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: addresses.map((address) {
              return ListTile(
                title: Text(address, style: AppStyles.NormalText),
                onTap: () {
                  setState(() {
                    selectedAddress = address;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showCpfCnpjDialog() {
    TextEditingController cpfController = TextEditingController(text: cpfCnpj);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Digite o CPF/CNPJ', style: AppStyles.productTitle),
          content: TextField(
            controller: cpfController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 236, 233, 233),
              hintText: 'Digite aqui',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar', style: AppStyles.NormalText),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cpfCnpj = cpfController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xFFFFD700),
              ),
              child: Text(
                'Salvar',
                style: AppStyles.NormalText,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentOption(String label, IconData icon) {
    final isSelected = selectedPaymentMethod == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = label;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDD741) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
