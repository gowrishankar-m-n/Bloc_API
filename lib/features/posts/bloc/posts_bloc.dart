import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:bloc_api/features/posts/repos/posts_repo.dart';

import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostsAddEvent>(postsAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
    PostsInitialFetchEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsFectchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();

    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postsAddEvent(
    PostsAddEvent event,
    Emitter<PostsState> emit,
  ) async {
    bool success = await PostsRepo.addPosts();
    print(success);
    if (success) {
      emit(PostsAddSuccessState());
    } else {
      emit(PostsAddErrorState());
    }
  }
}
