import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';


class MovieSlider extends StatelessWidget {
  // const MovieSlider({Key? key}) : super(key: key);

  final List<Movie> popular;

  const MovieSlider({Key? key, required this.popular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.popular.length == 0) {
      return Container( width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popular.length,
                itemBuilder: (_, int index) => _MoviePoster( popular: popular[index],
                )),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie popular;

  const _MoviePoster({Key? key, required this.popular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: popular),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(  placeholder: AssetImage('assets/no-image.jpg'), image: NetworkImage(popular.fullPosterPath), width: 130, height: 190, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(style: TextStyle( fontStyle: FontStyle.italic, color:Colors.white), popular.title, maxLines: 2, overflow: TextOverflow.ellipsis,  textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}