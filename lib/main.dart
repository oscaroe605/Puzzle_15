import 'package:flutter/material.dart';

void main() {
  runApp(const MiJuegoPuzzle());
}

class MiJuegoPuzzle extends StatelessWidget {
  const MiJuegoPuzzle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '15-Puzzle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaJuego(),
    );
  }
}

class PantallaJuego extends StatefulWidget {
  const PantallaJuego({super.key});

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  // Las 16 casillas del tablero: 0 representa el espacio vacío.
  List<int> fichas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

  // Función para mover fichas si están adyacentes al espacio vacío (0)
  void _moverFicha(int index) {
    int vacioIndex = fichas.indexOf(0);

    // Calcular la fila y columna de la ficha presionada y del hueco vacío
    int filaFicha = index ~/ 4;
    int colFicha = index % 4;
    int filaVacio = vacioIndex ~/ 4;
    int colVacio = vacioIndex % 4;

    // Verificar si la ficha está arriba, abajo, a la izquierda o a la derecha del hueco
    bool esAdyacente =
        (filaFicha == filaVacio && (colFicha - colVacio).abs() == 1) ||
        (colFicha == colVacio && (filaFicha - filaVacio).abs() == 1);

    if (esAdyacente) {
      setState(() {
        fichas[vacioIndex] = fichas[index];
        fichas[index] = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15-Puzzle Game'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                int valor = fichas[index];

                // Si es 0, renderizamos el espacio vacío
                if (valor == 0) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }

                // Si tiene número, envolvemos en GestureDetector para capturar clics
                return GestureDetector(
                  onTap: () => _moverFicha(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$valor',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
