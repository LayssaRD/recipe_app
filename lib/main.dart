import 'package:flutter/material.dart';
import 'pages/receita_list_page.dart';

void main() {
  runApp(const ReceitaApp());
}

class ReceitaApp extends StatelessWidget {
  const ReceitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Receitas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ReceitaListPage(),
    );
  }
}
