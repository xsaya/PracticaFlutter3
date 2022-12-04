import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;
  const CardSwiper({ Key? key, required this.movies }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(movies.isEmpty) {
      return SizedBox( width: double.infinity, height: size.height*0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        width: double.infinity, height: size.height * 0.5, color: Colors.black12,
        child: Swiper(
          itemCount: movies.length, layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6, itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            //print(movie.posterPath);
            return GestureDetector(
              //Contexto, details = ruta(details_screen), definida en main, arguments List<Movie> movies
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage( placeholder: const AssetImage('assets/no-image.jpg'), image: NetworkImage(movie.fullPosterPath),fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}
