import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/screens/login/login.dart';

class MinhaConta extends StatelessWidget {
  const MinhaConta({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para os campos de CPF, Telefone e Nascimento
    final TextEditingController cpfController = TextEditingController();
    final TextEditingController telefoneController = TextEditingController();
    final TextEditingController nascimentoController = TextEditingController();

    // Função para exibir notificação de sucesso
    void showNotification(String message) {
      final overlay = Overlay.of(context);
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
                    Icons.check_circle,
                    color: Color(0xffFDD741),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    message,
                    style:  GoogleFonts.poppins(
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título e linha decorativa
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text('Minha Conta', style: AppStyles.titlePage),
                  linha(300),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            // Subtítulo
            Center(
              child: Text(
                'Informação de cadastro',
                style: AppStyles.appTitle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            // Nome e E-mail com ApiController
            Consumer<ApiController>(
              builder: (context, apiController, _) {
                final username = apiController.username;
                final email = apiController.email;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo Nome
                    TextField(
                      controller: TextEditingController(text: username),
                      style: AppStyles.NormalText, // Estilo do texto
                      decoration: InputDecoration(
                        labelText: 'Nome:',
                        labelStyle: AppStyles.NormalText, // Estilo da label
                        contentPadding: const EdgeInsets.only(bottom: 8),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                        ),
                      ),
                      readOnly: true, // Campo somente leitura
                    ),
                    const SizedBox(height: 40),
                    // Campo E-mail
                    TextField(
                      controller: TextEditingController(text: email),
                      style: AppStyles.NormalText,
                      decoration: InputDecoration(
                        labelText: 'E-mail:',
                        labelStyle: AppStyles.NormalText,
                        contentPadding: const EdgeInsets.only(bottom: 8),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            // Input para CPF
            TextField(
              controller: cpfController,
              style: AppStyles.NormalText,
              decoration: InputDecoration(
                labelText: 'CPF:',
                labelStyle: AppStyles.NormalText,
                contentPadding: const EdgeInsets.only(bottom: 8),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Input para Telefone
            TextField(
              controller: telefoneController,
              style: AppStyles.NormalText,
              decoration: InputDecoration(
                labelText: 'Telefone:',
                labelStyle: AppStyles.NormalText,
                contentPadding: const EdgeInsets.only(bottom: 8),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Input para Nascimento
            TextField(
              controller: nascimentoController,
              style: AppStyles.NormalText,
              decoration: InputDecoration(
                labelText: 'Nascimento:',
                labelStyle: AppStyles.NormalText,
                contentPadding: const EdgeInsets.only(bottom: 8),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e6e6)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Botões de ação
            Center(
              child: Column(
                children: [
                  // Botão "Salvar alteração"
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final cpf = cpfController.text;
                        final telefone = telefoneController.text;
                        final nascimento = nascimentoController.text;

                        // Simulação de registro de dados
                        print(
                            'Dados salvos: CPF: $cpf, Telefone: $telefone, Nascimento: $nascimento');

                        // Exibir a notificação de sucesso
                        showNotification('Alterações salvas com sucesso!');
                      },
                      child: Text('Salvar alterações', style: AppStyles.button),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botão "Sair da conta"
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.yellow),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Redireciona para a tela de login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        'Sair da conta',
                        style: AppStyles.button,
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
}
