part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

class PostsFectchingLoadingState extends PostsState {}

class PostsFetchingErrorState extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({required this.posts});
}

class PostsAddSuccessState extends PostsActionState {}

class PostsAddErrorState extends PostsActionState {}
