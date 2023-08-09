import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_films/view/component/one_film.dart';
import 'package:movie_films/view_model/Bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Movies"),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
          ),
          body: state is GetMoviesSuccess
              ? Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Search"),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        GridView.count(
                          crossAxisSpacing: 5,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 16,
                          children: List.generate(
                            cubit.moviemodel.results!.length,
                            (index) => Film(
                              index: index,
                              moviemodel: cubit.moviemodel,
                            ),
                          ),
                          shrinkWrap: true,
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        );
      },
    );
  }
}
