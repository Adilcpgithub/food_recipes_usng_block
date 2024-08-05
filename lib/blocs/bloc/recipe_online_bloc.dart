import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_with_bloc/model/recipe_model.dart';

part 'recipe_online_event.dart';
part 'recipe_online_state.dart';

class RecipeOnlineBloc extends Bloc<RecipeOnlineEvent, RecipeOnlineState> {
  RecipeOnlineBloc() : super(RecipeOnlineInitial()) {
    on<RecipeOnlineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
