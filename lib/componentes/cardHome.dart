import 'package:flutter/material.dart';
import 'package:tcc_senai/componentes/style.dart';

Container CardHome (String image, String name, String preco){
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 220,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Cor da sombra
                spreadRadius: 2, // Espalhamento da sombra
                blurRadius: 3, // Suavização da sombra
                offset:const Offset(0, 3), // Deslocamento horizontal e vertical da sombra
              ),
            ],

          ),
          child: Image.network(image, width: 50),
        ),
        const SizedBox(height: 8,),
        Text(name,
        style: AppStyles.productDescription,
        
        ),
        Text(
          'A partir de R\$' + preco, 
          style: AppStyles.productTitle,
        ),
      ],
    ),
    );
  }