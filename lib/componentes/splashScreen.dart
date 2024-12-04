import 'package:flutter/material.dart';
import 'package:tcc_senai/componentes/navigation_bar.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializa o AnimationController com a duração das animações
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Animação de deslize da imagem (vem da direita)
    _imageSlideAnimation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animação de deslize do texto (vem da esquerda)
    _textSlideAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Inicia as animações
    _controller.forward();

    // Navega para a tela principal após a animação
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(_createFadeRoute());
    });
  }

  // Método para criar uma transição suave de fade
  Route _createFadeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => NavBottom(), // Tela de navegação inferior
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Definindo a animação de fade
        var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Imagem de fundo fixo, ocupando toda a tela
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('../assets/fundo.png'),  // Caminho da sua imagem de fundo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Container para centralizar a imagem e o texto
            Column(
              mainAxisSize: MainAxisSize.min, // O tamanho mínimo para o column
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza a coluna
              children: [
                // Imagem vindo da direita
                SlideTransition(
                  position: _imageSlideAnimation,
                  child: Image.asset(
                    '../assets/logoAmarela.png',  // Caminho correto da imagem
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                // Texto vindo da esquerda, abaixo da imagem
                SlideTransition(
                  position: _textSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),  // Ajuste o espaço entre a imagem e o texto
                    child: Text(
                      'Light Burger',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFDD741),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
