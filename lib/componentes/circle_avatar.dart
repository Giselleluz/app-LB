import 'package:flutter/material.dart';

Container circleAvatar(double largura, double altura, String img){
  return Container(
      width: largura,
      height: altura,
      margin: const EdgeInsets.all(8),
      child: CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(img),
      backgroundColor:  const Color.fromARGB(255, 240, 232, 232),
    ),
  );
}