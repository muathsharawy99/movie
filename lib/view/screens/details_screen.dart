import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_films/view_model/Bloc/home_cubit.dart';
import 'package:movie_films/view_model/network/dio_helper/end_points.dart';

class DetailsScreen extends StatelessWidget {
  int id;

  DetailsScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomeCubit()..getDetails(id),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit().get(context);
            if (state is GetDetailsSuccess) {
              print(cubit.detail?.title);
            }
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    shadows: [
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(1, 1),
                        blurRadius: 3.r,
                      ),
                    ],
                    Icons.arrow_back,
                  ),
                ),
              ),
              body: state is GetDetailsLoading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height -
                                  (MediaQuery.of(context).size.height / 3),
                              width: double.infinity,
                              color: Colors.white,
                              child: Hero(
                                tag: '${cubit.detail?.id}',
                                child: Image.network(
                                  "${EndPoints.imagePath}${cubit.detail?.posterPath}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${cubit.detail?.originalTitle}",
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                RatingBar(
                                  initialRating:
                                      (cubit.detail?.voteAverage ?? 0) / 2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemSize: 25.w,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
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
                                  width: 5.w,
                                ),
                                Text(
                                  "${cubit.detail?.voteAverage}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${cubit.detail?.overview}",
                              style: TextStyle(fontSize: 18.sp),
                            ),

                            ///hereeeeeeeeeee
                          ],
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}
