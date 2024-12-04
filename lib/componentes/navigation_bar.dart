import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcc_senai/controllers/shopping_cart_controller.dart';
import 'package:tcc_senai/screens/cardapio/cardapio.dart';
import 'package:tcc_senai/screens/carrinho/carrinho.dart';
import 'package:tcc_senai/screens/home/home_page.dart';
import 'package:tcc_senai/screens/perfil/perfil.dart';

class NavBottom extends StatefulWidget {
  const NavBottom({super.key});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int _selectedIndex = 0;

  // Lista de telas para navegação
  final List<Widget> _pages = [
    HomePage(),
    ProductPage(),
    CartPage(),
    Perfil(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<ShoppingCartController>(context);

    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xffFDD741),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.house, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.utensils, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                      if (cartController.itemCount > 0)
                        Positioned(
                          right: 0,
                          top: 5,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              cartController.itemCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.solidUser, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
