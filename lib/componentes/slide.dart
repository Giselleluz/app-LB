import 'dart:async';

import 'package:flutter/material.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  int paginaAtual = 0;
  int quantidadeDePaginas = 3;
  PageController controller = PageController();
  List<double> progresso =  [0.0,0.0,0.0];
  
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int page = controller.page!.round();
      if (paginaAtual != page) {
        setState(() {
          paginaAtual = page;
        });
      }
    });
    proximaPage();
    iniciarOProgresso();
  }

  void proximaPage() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (paginaAtual < quantidadeDePaginas - 1) {
        controller.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        controller.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      }
    });
  }

  iniciarOProgresso(){
    Timer.periodic(const Duration(milliseconds:50), (timer){
      setState((){
        if(progresso[paginaAtual] < 1){
          progresso[paginaAtual] += 0.02;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void resetar(){
    for(int i = 0; i < quantidadeDePaginas; i++){
      progresso[i] += 0;
    }
    iniciarOProgresso();
  }

  List<Widget> indicator(){
    List<Widget> list = [];
    for(int i = 0; i < quantidadeDePaginas; i++){
      list.add(Container(
        width: 50,
        height: 5,
        margin: const EdgeInsets.all(8),
        child:LinearProgressIndicator(
          value: progresso[i],
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            paginaAtual == i?const Color(0xFFFFD700) : const Color(0xFFFFD700),
          ),
        ),
      ));
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      margin: const EdgeInsets.all(8),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView(
            controller: controller,
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('../assets/Banner1.png'))),
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('../assets/Banner2.png'))),
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('../assets/Banner3.png'))),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicator(),
          ),
        ],
      ),
    );
  }
}