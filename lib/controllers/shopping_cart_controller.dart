import 'package:flutter/material.dart';
import 'package:tcc_senai/model/product_model.dart';

class ShoppingCartController with ChangeNotifier{
//armazena o produto no carrinho e quantidade 
final Map<ProductModel, int> _item = {};
//criamos um get para exibir esses produtos
List<ProductModel> get items => _item.keys.toList();

//add produto ao carrinho
void addProduct(ProductModel product){
  if(_item.containsKey(product)){
    _item[product] = _item[product] ! +1; //caso um produto desses esteja no carrino, aumenta a quantidade
  } else{
    _item[product] = 1; //caso nao tenho o produto, adiciona pela primeira vez
  }
  notifyListeners();
}

//remover do carrinho

void removeProduct(ProductModel product){
  if(_item.containsKey(product) && _item[product]! >0){
    _item[product] = _item[product] ! -1;
    if(_item[product] == 0){
      _item.remove(product);
    }
  }
  notifyListeners();
}

//obtem a quantidade total de items no carrinho
int get itemCount => _item.values.fold(
  0, (previousValue, element) => previousValue + element);

//calcular o preço total dos items
double get totalPrice => _item.entries.fold(
  0.0, (previousValue, element) => 
  previousValue + element.key.preco * element.value);

//quantidade de um produto especifico
int getQuantity(ProductModel productModel){
  return _item[productModel]?? 0;
}
}