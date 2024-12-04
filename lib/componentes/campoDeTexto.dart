import 'package:flutter/material.dart';

class CampoDeTexto extends StatelessWidget {
  final String labelText;
  final TextEditingController controller; // Adicione o parâmetro 'controller'
  final bool obscureText;

  const CampoDeTexto({
    super.key,
    required this.labelText,
    required this.controller, // Certifique-se de que 'controller' é requerido
    this.obscureText = false, // Define como false por padrão, caso não seja para senha
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller, // Use o controller passado
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFe6e6e6),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0xFF555555),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        ),
      ),
    );
  }
}
