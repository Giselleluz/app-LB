import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_senai/componentes/style.dart';

class MeusEnderecos extends StatefulWidget {
  @override
  _MeusEnderecosState createState() => _MeusEnderecosState();
}

class _MeusEnderecosState extends State<MeusEnderecos> {
  List<Map<String, String>> _enderecos = [
    {"rua": "Av. Paulista", "numero": "1234", "cidade": "São Paulo"},
    {"rua": "Rua das Flores", "numero": "567", "cidade": "Campinas"},
  ];

  void _adicionarEndereco() {
    showDialog(
      context: context,
      builder: (context) => AdicionarEnderecoModal(
        onSalvar: (String rua, String numero, String cidade) {
          setState(() {
            _enderecos.add({"rua": rua, "numero": numero, "cidade": cidade});
          });
        },
      ),
    );
  }

  void _mostrarOpcoesEndereco(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _enderecos.removeAt(index);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Excluir',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Voltar',
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text('Meus Endereços', style: AppStyles.titlePage),
                  linha(300),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aqui você pode conferir seus endereços cadastrados e adicionar outros se desejar.',
              style: AppStyles.NormalText,
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: _enderecos.length + 1,
                itemBuilder: (context, index) {
                  if (index == _enderecos.length) {
                    return GestureDetector(
                      onTap: _adicionarEndereco,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Adicionar novo endereço',
                              style: AppStyles.NormalText,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  final endereco = _enderecos[index];
                  return GestureDetector(
                    onTap: () => _mostrarOpcoesEndereco(index),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${endereco["rua"]}, ${endereco["numero"]}, ${endereco["cidade"]}',
                        style: AppStyles.productTitle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdicionarEnderecoModal extends StatefulWidget {
  final Function(String, String, String) onSalvar;

  const AdicionarEnderecoModal({required this.onSalvar});

  @override
  _AdicionarEnderecoModalState createState() => _AdicionarEnderecoModalState();
}

class _AdicionarEnderecoModalState extends State<AdicionarEnderecoModal> {
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField('Endereço:', _ruaController),
          SizedBox(height: 8),
          _buildTextField('Número:', _numeroController),
          SizedBox(height: 8),
          _buildTextField('Cidade:', _cidadeController),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final rua = _ruaController.text.trim();
              final numero = _numeroController.text.trim();
              final cidade = _cidadeController.text.trim();
              if (rua.isNotEmpty && numero.isNotEmpty && cidade.isNotEmpty) {
                widget.onSalvar(rua, numero, cidade);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Salvar',
              style: AppStyles.productTitle,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFDD741),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(double.infinity, 48),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar e voltar',
              style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.productTitle,
        ),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
