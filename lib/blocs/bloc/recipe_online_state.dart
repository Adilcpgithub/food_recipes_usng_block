part of 'recipe_online_bloc.dart';

sealed class RecipeOnlineState extends Equatable {
  const RecipeOnlineState();
  
  @override
  List<Object> get props => [];
}

final class RecipeOnlineInitial extends RecipeOnlineState {}
