import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Coge primera instancia de provider y la mete en variable
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartelera'),

        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_sharp)),
          Padding(padding: EdgeInsets.only(right: 2))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              MovieSlider(popular: moviesProvider.onDisplayPopulars),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent

              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
