import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_films/model/movie_model.dart';
import 'package:movie_films/view/screens/details_screen.dart';
import 'package:movie_films/view_model/navigation/navigation.dart';
import 'package:movie_films/view_model/network/dio_helper/end_points.dart';

class Film extends StatelessWidget {
  Film({required this.index, Key? key, required this.moviemodel})
      : super(key: key);
  int index;
  MovieModel moviemodel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.push(
          context,
          DetailsScreen(
            id: moviemodel.results?[index].id ?? 505642,
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Hero(
                tag: '${moviemodel.results?[index].id}',
                child: Image.network(
                  "${EndPoints.imagePath}${moviemodel.results?[index].posterPath}",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              RatingBar(
                initialRating:
                    (moviemodel.results?[index].voteAverage ?? 0.0) / 2,
                ignoreGestures: true,
                minRating: 0,
                maxRating: 10,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 25.w,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    half: Icon(
                      Icons.star_half_rounded,
                      color: Colors.yellow,
                    ),
                    empty: Icon(
                      Icons.star_border,
                      color: Colors.grey,
                    )),
                onRatingUpdate: (double value) {
                  print(value);
                },
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "${moviemodel.results?[index].voteAverage}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "${moviemodel.results?[index].originalTitle}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.fade,
            ),
            softWrap: false,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
