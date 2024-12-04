import 'package:flutter/material.dart';

Container Carrossel(String img) {
  return Container(
    width: 130,
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color:const Color.fromARGB(255, 240, 232, 232),
    ),
    child: Image.asset(img),
  );
}
