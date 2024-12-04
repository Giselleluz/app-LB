import 'package:flutter/material.dart';
import 'package:tcc_senai/componentes/style.dart';  // Importe seu estilo

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
             Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título e linha decorativa
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Uso e privacidade',
                      style: AppStyles.titlePage,
                    ),
                    linha(300),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              // Texto informativo sobre a privacidade
              Text(
                '1. Coleta de Dados:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'Coletamos informações pessoais, como nome, endereço de e-mail e dados de uso do aplicativo, para melhorar a experiência do usuário e fornecer serviços personalizados.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
              Text(
                '2. Uso das Informações:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'As informações coletadas são utilizadas para personalizar o conteúdo, melhorar a funcionalidade do aplicativo e oferecer suporte adequado aos usuários.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
              Text(
                '3. Proteção de Dados:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'Adotamos medidas de segurança adequadas para proteger os dados pessoais dos usuários contra acesso não autorizado, alteração ou destruição.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
              Text(
                '4. Compartilhamento de Informações:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'Não compartilhamos suas informações pessoais com terceiros, exceto quando necessário para fornecer os serviços do aplicativo ou conforme exigido por lei.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
              Text(
                '5. Alterações na Política de Privacidade:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'Podemos atualizar nossa política de privacidade periodicamente. As alterações serão comunicadas por meio do aplicativo.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
              Text(
                '6. Aceitação da Política:',
                style: AppStyles.productDescription,
              ),
              const SizedBox(height: 8),
              Text(
                'Ao utilizar nosso aplicativo, você concorda com a nossa política de privacidade e com o uso de seus dados conforme descrito acima.',
                style: AppStyles.NormalText,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        ],

      ),
    );
  }
}
