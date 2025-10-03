import 'package:bloc_api/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsbloc = PostsBloc();

  @override
  void initState() {
    postsbloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          postsbloc.add(PostsAddEvent());
        },
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsbloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFectchingLoadingState:
              return Center(child: CircularProgressIndicator());

            case PostFetchingSuccessfulState:
              final succesState = state as PostFetchingSuccessfulState;
              return Container(
                child: ListView.builder(
                  itemCount: succesState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      color: Colors.teal.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(succesState.posts[index].title),
                          Text(succesState.posts[index].body),
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return Container(color: Colors.red);
          }
        },
      ),
    );
  }
}
