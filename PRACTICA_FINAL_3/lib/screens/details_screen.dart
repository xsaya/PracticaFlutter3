import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';
import '../models/models.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie peli =  ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: peli),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: peli),
                _Overview(movie: peli),
                CastingCards(peli.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo, expandedHeight: 200, floating: false, pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity, alignment: Alignment.bottomCenter, color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10), child: Text( movie.title, style: const TextStyle(fontSize: 16))
        ),
        background: FadeInImage( placeholder: AssetImage('assets/loading.gif'), image: NetworkImage(movie.fullPosterPath), fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage( placeholder: AssetImage('assets/loading.gif'), image: NetworkImage(movie.fullPosterPath), height: 150
            ),
          ),
          const SizedBox( width: 20),
          Container(
            width: 200, height: 120,
            child: Column(
              children: [
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis,  maxLines: 2),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    const SizedBox(width: 5), Text ('${movie.voteAverage}', style: textTheme.caption),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  //Declaramos objeto movie, que iremos pasando en lista al llamar al widget
  //iremos accediendo a sus respectivas propiedades.
  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}