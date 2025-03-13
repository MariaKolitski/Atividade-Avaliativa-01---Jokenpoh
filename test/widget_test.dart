import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokenpô',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String escolhaUsuario = '';
  String escolhaApp = 'pedra'; // Opção padrão do app

  String _gerarEscolhaComputador() {
    final random = Random();
    return ['pedra', 'papel', 'tesoura'][random.nextInt(3)];
  }

  void _selecionarJogada(String escolha) {
    setState(() {
      escolhaUsuario = escolha;
      escolhaApp = _gerarEscolhaComputador();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(
          escolhaUsuario: escolhaUsuario,
          escolhaComputador: escolhaApp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedra, Papel, Tesoura'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Escolha do APP (Aleatório)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/$escolhaApp.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 40),
          const Text(
            'Escolha do usuário',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _criarBotaoEscolha('pedra'),
              _criarBotaoEscolha('papel'),
              _criarBotaoEscolha('tesoura'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _criarBotaoEscolha(String escolha) {
    return GestureDetector(
      onTap: () => _selecionarJogada(escolha),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/$escolha.png',
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}

class TelaResultado extends StatelessWidget {
  final String escolhaUsuario;
  final String escolhaComputador;

  const TelaResultado({
    super.key,
    required this.escolhaUsuario,
    required this.escolhaComputador,
  });

  String _obterResultado() {
    if (escolhaUsuario == escolhaComputador) return 'Empate!';
    if ((escolhaUsuario == 'pedra' && escolhaComputador == 'tesoura') ||
        (escolhaUsuario == 'papel' && escolhaComputador == 'pedra') ||
        (escolhaUsuario == 'tesoura' && escolhaComputador == 'papel')) {
      return 'Você venceu!';
    }
    return 'Você perdeu!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/$escolhaUsuario.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 20),
                const Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/$escolhaComputador.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _obterResultado(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}