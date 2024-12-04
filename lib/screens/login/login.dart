import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_senai/componentes/campoDeTexto.dart';
import 'package:tcc_senai/componentes/circle_avatar.dart';
import 'package:tcc_senai/componentes/navigation_bar.dart';
import 'package:tcc_senai/componentes/splashScreen.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/screens/cadastro/cadastro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiController _apiController = ApiController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final success = await _apiController.loginUser(
        _emailController.text,
        _passwordController.text,
      );

      if (success != null) {
        // Verifica se a resposta não é nula
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                   Splashscreen()), // Navega para a tela inicial
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Falha no login. Verifique suas credenciais.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())), // Exibe mensagem de erro
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: 24,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Image.asset(
            '../assets/logoAmarela.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          CampoDeTexto(
            labelText: 'Email',
            controller: _emailController,
          ),
          CampoDeTexto(
            labelText: 'Senha',
            controller: _passwordController,
            obscureText: true,
          ),
          Container(
            width: 400,
            height: 64,
            margin: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: _login,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFFDD741)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text(
                'Entrar',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Não tem uma conta? ',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            GestureDetector(
              onTap: () {
                // Navega para a página de login quando o texto é tocado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child:  Text(
                'Cadastre-se',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
            width: 400,
            child: Divider(
              color: Color.fromARGB(115, 63, 61, 61),
              thickness: 2.0,
              height: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              circleAvatar(60, 60, '../assets/google.png'),
              circleAvatar(60, 60, '../assets/facebook.png'),
              circleAvatar(50, 50, '../assets/apple.png'),
            ],
          ),
        ],
      ),
    );
  }
}
