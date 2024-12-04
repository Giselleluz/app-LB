import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/menuPerfil.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/screens/perfil/endere%C3%A7o.dart';
import 'package:tcc_senai/screens/perfil/favoritos.dart';
import 'package:tcc_senai/screens/perfil/meusPedidos.dart';
import 'package:tcc_senai/screens/perfil/minhaconta.dart';
import 'package:tcc_senai/screens/perfil/uso_e_privacidade.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text('Light Burger', style: AppStyles.titlePage),
              linha(180),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Minha Conta', style: AppStyles.appTitle),
          ),
          Column(
            children: [
              divider(MediaQuery.of(context).size.width, 0.5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  MinhaConta(),
                    ),
                  );
                },
                child: Consumer<ApiController>(
                builder: (context, apiController, _) {
                  final username = apiController.username;
                  final email = apiController.email;
                  return menuPerfil(
                  FontAwesomeIcons.user,
                  '${username}',
                  '${email}'
                );
                },
                            ),
              ),
              
              divider(MediaQuery.of(context).size.width, 0.5),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  MeusEnderecos(),
                    ),
                  );
                },
                child: menuPerfil(
                  FontAwesomeIcons.mapMarkerAlt,
                  'Endereço',
                  'Seus Endereços salvos',
                ),
              ),
  
              divider(MediaQuery.of(context).size.width, 0.5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  FavoritesPage(),
                    ),
                  );
                },
                child: menuPerfil(
                  FontAwesomeIcons.star,
                  'Favoritos',
                  'Seus Lanches favoritos ',
                ),
              ),
            
              divider(MediaQuery.of(context).size.width, 0.5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeusPedidosPage(),
                    ),
                  );
                },
                child: menuPerfil(
                  FontAwesomeIcons.shoppingBag,
                  'Meus pedidos',
                  'Veja seus pedidos',
                ),
              ),
              divider(MediaQuery.of(context).size.width, 0.5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                child: menuPerfil(
                  FontAwesomeIcons.gear,
                  'Uso e privacidade',
                  'Diretrizes de Privacidade de Dados',
                ),
              ),
               divider(MediaQuery.of(context).size.width, 0.5),
            ],
          ),
        ],
      ),
    );
  }
}