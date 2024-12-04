import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/componentes/navigation_bar.dart';
import 'package:tcc_senai/controllers/favorite_controller.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/controllers/user_controller.dart';
import 'package:tcc_senai/screens/cadastro/cadastro.dart';
import 'package:tcc_senai/screens/login/login.dart';
import 'package:tcc_senai/screens/perfil/minhaconta.dart';
import 'package:tcc_senai/screens/perfil/perfil.dart';


void main() {
  runApp(
    MultiProvider(
    providers: [
      //permite que todas as classes abaixo dessa se comuniquem com o shoppingController
      ChangeNotifierProvider(create: (_) => ShoppingCartController()),
      ChangeNotifierProvider(create: (_) => FavoriteController()),
      ChangeNotifierProvider(create: (_) => ApiController()),
    ],
    child:  MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        ),
        
      debugShowCheckedModeBanner: false,
    );
  }
}