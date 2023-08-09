import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_films/model/movie_model.dart';
import 'package:movie_films/view_model/network/dio_helper/dio_helper.dart';
import 'package:movie_films/view_model/network/dio_helper/end_points.dart';

import '../../model/movie_details_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  var moviemodel = MovieModel();
  MovieDetailsModel? detail;

  void getMovies() {
    emit(GetMoviesLoading());
    DioHelper.get(endPoint: EndPoints.popularEndPoint).then((value) {
      moviemodel = MovieModel.fromJson(value.data);
      emit(GetMoviesSuccess());
    }).onError((error, stackTrace) {
      emit(GetMoviesError());
    });
  }

  void getDetails(int id) {
    emit(GetDetailsLoading());
    DioHelper.get(endPoint: "${EndPoints.moviesEndPoint}/$id").then((value) {
      detail = MovieDetailsModel.fromJson(value.data);
      emit(GetDetailsSuccess());
    }).catchError((error){
      emit(GetDetailsError());
    });
  }
}
