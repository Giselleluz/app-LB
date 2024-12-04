import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_senai/componentes/campoDeTexto.dart';
import 'package:tcc_senai/componentes/circle_avatar.dart';
import 'package:tcc_senai/componentes/navigation_bar.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/model/user_model.dart';
import 'package:tcc_senai/screens/home/home_page.dart';
import 'package:tcc_senai/screens/introducao/introduction_sreen.dart';
import 'package:tcc_senai/screens/login/login.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiController _apiController = ApiController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    UserModel user = UserModel(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    final success = await _apiController.registerUser(user.name, user.email, user.password);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroductionScreen()), // Navega para a tela inicial
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no cadastro. Tente novamente.')),
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
            'Cadastre-se',
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
          Column(
            children: [
              CampoDeTexto(
                labelText: 'Nome',
                controller: _nameController,
              ),
              CampoDeTexto(
                labelText: 'Email',
                controller: _emailController,
              ),
              CampoDeTexto(
                labelText: 'Senha',
                controller: _passwordController,
                obscureText: true,
              ),
            ],
          ),
          Container(
            width: 400,
            height: 64,
            margin: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: _register,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFFFDD741)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text(
                'Cadastre-se',
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
              'Já tem uma conta? ',
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child:  Text(
                'Faça Login',
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
