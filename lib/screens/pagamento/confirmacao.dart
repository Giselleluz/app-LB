import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_senai/componentes/navigation_bar.dart';
import 'package:tcc_senai/componentes/style.dart';

class ConfirmPage extends StatefulWidget {
  final String selectedAddress;
  final String paymentMethod;
  final String total;
  final String? cpfCnpj;

  const ConfirmPage({
    Key? key,
    required this.selectedAddress,
    required this.paymentMethod,
    required this.total,
    this.cpfCnpj,
  }) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  int timeRemaining = 25; // Tempo inicial em segundos
  late Timer timer;
  double rating = 0; // Avaliação inicial

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        timer.cancel();
        showFeedbackModal();
      }
    });
  }

  void showFeedbackModal() {
    TextEditingController commentController = TextEditingController();
    double localRating =
        rating; // Variável local para atualizar o estado do rating

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return AlertDialog(
              title: Center(child: Text('Deixe seu feedback', style: AppStyles.appTitle)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avaliação por estrelas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color:
                              index < localRating ? const Color(0xFFFDD741) : Colors.grey,
                        ),
                        onPressed: () {
                          setModalState(() {
                            localRating = index + 1.0; // Atualiza localmente
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  // Campo de comentário
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Arredondar bordas
                        borderSide: BorderSide.none, // Sem borda externa
                      ),

                      filled: true,
                      fillColor: const Color.fromARGB(
                          255, 236, 233, 233), // Cor de fundo
                      hintText: 'Escreva seu comentário',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: AppStyles.NormalText,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Salvar o feedback (Exemplo de print)
                    setState(() {
                      rating = localRating; // Salva o rating global
                    });
                    print('Avaliação: $rating estrelas');
                    print('Comentário: ${commentController.text}');
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDD741),
              ),
                  child: Text(
                    'Enviar',
                    style:  AppStyles.NormalText,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text('Confirmação de pagamento',
                      style: AppStyles.titlePageConfirmacao),
                  linha(340),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Icon(
              Icons.check_circle,
              size: 60,
              color: Colors.black,
            ),
            const SizedBox(height: 24),

            // Informações de endereço
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_shipping, color: const Color(0xFFFDD741),),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedAddress,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Osasco',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Ação ao clicar em Destino (opcional)
                  },
                  child: Text(
                    'Destino',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Resumo do pagamento
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'R\$ ${widget.total}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Forma de pagamento
            Text(
              'Forma de pagamento: ${widget.paymentMethod}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // CPF/CNPJ
            if (widget.cpfCnpj != null)
              Text(
                'CPF/CNPJ: ${widget.cpfCnpj}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(height: 16),

            // Tempo estimado
            Text(
              'Tempo estimado: ${timeRemaining}s',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Mapa (simulado com um placeholder)
            // Mapa com informações sobrepostas
Expanded(
  child: Stack(
    children: [
      // Mapa reduzido
      ClipRRect(
        borderRadius: BorderRadius.circular(16), // Define o raio das bordas
        child: Container(
          width: double.infinity,
          height: 300, // Altura do mapa
          color: Colors.grey[200],
          child: Image.asset(
            '../assets/mapa.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Faz a imagem preencher o espaço
          ),
        ),
      ),
      // Caixa de informações sobreposta
      Positioned(
        top: 220, // Ajuste a posição vertical da caixa para ficar sobre o mapa
        left: 16,   // Margem esquerda
        right: 16,  // Margem direita
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
              Text(
                'Entregador: Marcelo',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Veículo: Moto',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Empresa parceira: Entrega Rápida',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),


            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavBottom()), // Substitua 'HomePage' pelo nome da sua tela inicial
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
                  'Voltar para a Home',
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
        
        
      ),
      
    );
  }
}
