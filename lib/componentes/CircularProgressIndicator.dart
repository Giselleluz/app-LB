import 'package:flutter/material.dart';

class RotatingLogo extends StatefulWidget {
  const RotatingLogo({Key? key}) : super(key: key);

  @override
  _RotatingLogoState createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Velocidade da rotação
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.141592653589793, // Rotações contínuas
            child: child,
          );
        },
        child: Image.asset(
          '../assets/logoAmarela.png', // Caminho da sua logo
          width: 100, // Tamanho personalizado
          height: 100,
        ),
      ),
    );
  }
}
