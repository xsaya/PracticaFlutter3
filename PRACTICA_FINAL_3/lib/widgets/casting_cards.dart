import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';



class CastingCards extends StatelessWidget {
  final int idMovie;
  const CastingCards(this.idMovie);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getMovieCast(idMovie),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {

          if(!snapshot.hasData) { return const Center( child: CircularProgressIndicator());}

          final casting = snapshot.data!;

          return Container(
              margin:  const EdgeInsets.only(bottom: 30),
              width: double.infinity,  height: 180,
              child: ListView.builder(
                  itemCount: casting.length, scrollDirection: Axis.horizontal, itemBuilder: (BuildContext context, int index) =>
                  _CastCard(casting: casting[index])
              )
          );
        });


  }
}

class _CastCard extends StatelessWidget {
  final Cast casting;

  const _CastCard({Key? key, required this.casting}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10), width: 110, height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage( placeholder: AssetImage('assets/no-image.jpg'), image: NetworkImage(casting.fullProfilePath), height: 140,width: 100, fit: BoxFit.cover),
          ),
           SizedBox( height: 5),
          Text( '${casting.name}', maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
