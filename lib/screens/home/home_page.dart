import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/cardHome.dart';
import 'package:tcc_senai/componentes/carrossel.dart';
import 'package:tcc_senai/componentes/slide.dart';
import 'package:tcc_senai/componentes/style.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/screens/home/contato.dart';
import 'package:tcc_senai/screens/login/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com Nome e Email
          Consumer<ApiController>(
            builder: (context, apiController, _) {
              final username = apiController.username ?? "Usuário";
              final email = apiController.email ?? "Email não disponível";

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                            Icons.person,
                            color: Color(0xffFDD741),
                            size: 16,
                          ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style:  GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              email,
                              style:  GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    divider(MediaQuery.of(context).size.width, 0.5), // Divider cinza claro
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 40),

          // Seção Horários
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Horários",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                linha(90), // Linha amarela abaixo do título
                const SizedBox(height: 8),
                 Text("Terça a sexta: 11h às 22h", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Sábado: 10h às 23h", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Domingo e feriados: 10h às 20h", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Seção Nossa Unidade
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Nossa Unidade",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                linha(150), // Linha amarela abaixo do título
                const SizedBox(height: 8),
                 Text("R. Ari Barroso, 305 - Pres. Altino,", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Osasco - SP, 06216-901", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 const SizedBox(height: 4),
                 Text("Escola e Faculdade SENAI Nadir Dias de Figueiredo.", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Seção Desenvolvedores
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Desenvolvedores",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                linha(180), // Linha amarela abaixo do título
                const SizedBox(height: 8),
                 Text("Mariana Meira Rigotto", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Giselle Luz Leite", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Gustavo Almeida Ferreira", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Gabriel Stoian", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                 Text("Heitor Machado", style:  GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
              ],
            ),
          ),
          

          // Rodapé com Ícones e Copyright
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 40),
                divider(MediaQuery.of(context).size.width, 0.5),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(FontAwesomeIcons.instagram, color: Color(0xffFDD741)),
                    SizedBox(width: 16),
                    Icon(FontAwesomeIcons.facebook, color: Color(0xffFDD741)),
                    SizedBox(width: 16),
                    Icon(FontAwesomeIcons.github, color: Color(0xffFDD741)),
                  ],
                ),
                const SizedBox(height: 20),
                 Text(
                  "© Copyright 2024 Light Burger",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Consumer<ApiController>(
              builder: (context, apiController, _) {
                final username = apiController.username;
                return Text(
                  username != null && username.isNotEmpty
                      ? 'Olá, $username'
                      : 'Olá, visitante!',
                  style: AppStyles.appTitle,
                );
              },
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                '../assets/menu.png',
                height: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(30.0), // Arredondamento suave
                  color: const Color.fromARGB(
                      255, 236, 233, 233), // Fundo do campo de texto
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
                            debugPrint('Texto digitado: $value');
                          },
                          decoration: const InputDecoration(
                            hintText: 'Pesquisar...', // Placeholder do campo
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
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
                          debugPrint('Botão de busca clicado!');
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
          const Padding(
            padding: EdgeInsets.all(8),
            child: Slide(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Promoções delivery', style: AppStyles.appTitle),
                linha(220),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Stacker_Duplo_Bacon-thumb-cupom-m-d.png?mtime=20220825142918&focal=none",
                          'Light Duplo Bacon',
                          '31,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Nova-Embalagem_Shake-Morango_Externa.png?mtime=20240604104134&focal=none",
                          'Milkshake de Morango',
                          '14,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/cheddar_dp_crispy.png?mtime=20231129102105&focal=none",
                          'Duplo Cheddar',
                          '27,90'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lançamentos', style: AppStyles.appTitle),
                linha(160),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/BK-Chicken-2.png?mtime=20221202153255&focal=none",
                          'Chicken 10 Nuggets',
                          '19,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Rodeio-thumb.png?mtime=20230125075347&focal=none",
                          'Onion Light',
                          '26,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Chicken-Jr.png?mtime=20230703115830&focal=none",
                          'Chicken Burger',
                          '15,90'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Favoritos', style: AppStyles.appTitle),
                linha(120),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Sundae-Chocolate-thumb.png?mtime=20210916155926&focal=none",
                          'Sundae de Chocolate',
                          '9,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/Natural_One_Laranja_thumb_639x324.png?mtime=20210118103439&focal=none",
                          'Suco de Laranja',
                          '9,90'),
                      CardHome(
                          "https://d3sn2rlrwxy0ce.cloudfront.net/cheddar_dp_crispy.png?mtime=20231129102105&focal=none",
                          'Duplo Cheddar',
                          '27,90'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 90,
          ),
        ],
      ),
    );
  }
}
