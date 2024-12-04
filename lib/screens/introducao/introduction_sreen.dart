import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_senai/componentes/splashScreen.dart';
import 'package:tcc_senai/screens/cadastro/cadastro.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  
  //lista de páginas que são exibidas no slide introdutório
  final List<SingleIntroScreen> pages = [
     SingleIntroScreen(
      sideDotsBgColor:const Color.fromRGBO(253, 215, 65, 1),
      mainCircleBgColor:const Color.fromRGBO(253, 215, 65, 1),
      textStyle: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
      headerBgColor: Colors.white,
      title: 'Peça e retire',
      description:
          'Faça seu pedido app e retire na loja.',
      imageAsset: '../assets/shoppingUndraw.png',
    ),
     SingleIntroScreen(
      sideDotsBgColor:const Color.fromRGBO(253, 215, 65, 1),
      mainCircleBgColor: const Color.fromRGBO(253, 215, 65, 1),
      textStyle: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
      headerBgColor: Colors.white,
      title: 'Delivery Rápido!',
      description:
          'Pedir comida nunca foi tão fácil. Começe a pedir agora!',
      imageAsset: '../assets/deliveryUndraw.png' 
    ),
     SingleIntroScreen(
      sideDotsBgColor: const Color.fromRGBO(253, 215, 65, 1),
      mainCircleBgColor:const Color.fromRGBO(253, 215, 65, 1),
      textStyle: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
      headerBgColor: Colors.white,
      title: 'Sabor Único!', 
      description:
          'Experiência que conquista todos os paladares.',
      imageAsset: '../assets/saborUndraw.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: AnimatedIntroduction(
        containerBg:  Colors.white,
        textColor: Colors.white,
        skipText: '',
        nextText: 'Próximo',
        doneText: 'Entrar',
        footerBgColor: const Color.fromRGBO(253, 215, 65, 1),
        slides: pages,
        onDone: () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setBool('introShow', true);
  
  // Usando `Navigator.pushReplacement` para navegar para a tela de Cadastro
  if (context.mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Splashscreen()),
    );
  }
},
      ),
    );
  }
}
