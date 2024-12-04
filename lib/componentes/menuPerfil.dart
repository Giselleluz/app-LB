import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcc_senai/componentes/style.dart';

menuPerfil(IconData icon, String titulo, String descricao) {
  return Container(
    height: 90,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            FaIcon(icon),
            const SizedBox(width:16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo , style: AppStyles.productTitle),
                Text(descricao, style: AppStyles.productDescription),
              ],
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
