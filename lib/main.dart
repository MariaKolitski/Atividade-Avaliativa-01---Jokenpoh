import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokenpoh',
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
  String _gerarEscolhaComputador() {
    final random = Random();
    List<String> opcoes = ['pedra', 'papel', 'tesoura'];
    return opcoes[random.nextInt(opcoes.length)];
  }

  void _selecionarJogada(String escolha) {
    String escolhaApp = _gerarEscolhaComputador();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(
          escolhaUsuario: escolha,
          escolhaComputador: escolhaApp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jokenpoh',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Escolha Pedra, Papel ou Tesoura!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/circulo.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 100),
          const Text(
            'Faça a sua escolha:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
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

  String _obterImagemResultado() {
    if (escolhaUsuario == escolhaComputador) return 'empate.png';
    if ((escolhaUsuario == 'pedra' && escolhaComputador == 'tesoura') ||
        (escolhaUsuario == 'papel' && escolhaComputador == 'pedra') ||
        (escolhaUsuario == 'tesoura' && escolhaComputador == 'papel')) {
      return 'win.png';
    }
    return 'perdeu.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Escolha do usuário
            Image.asset(
              'assets/images/$escolhaUsuario.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'Sua escolha',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // VS
            const Text(
              'VS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // Escolha do computador
            Image.asset(
              'assets/images/$escolhaComputador.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'Escolha do computador',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 80),

            // Imagem de resultado
            Image.asset(
              'assets/images/${_obterImagemResultado()}',
              width: 250,
              height: 100,
            ),
            const SizedBox(height: 20),

            // Mensagem do resultado
            Text(
              _obterResultado(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // Botão para jogar novamente
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                child: const Text(
                  'Jogar Novamente',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
