import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/infinite_list/bottom_loader.dart';
import 'package:flutter_learning/views/bloc/infinite_list/post_bloc.dart';
import 'package:flutter_learning/views/bloc/infinite_list/post_event.dart';
import 'package:flutter_learning/views/bloc/infinite_list/post_state.dart';
import 'package:flutter_learning/views/bloc/infinite_list/post_widget.dart';
import 'package:flutter_learning/views/bloc/infinite_list/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;

class InfiniteList extends StatefulWidget {
  @override
  _InfiniteListState createState() {
    BlocSupervisor().delegate = SimpleBlocDelegate();
    return _InfiniteListState();
  }
}

class _InfiniteListState extends State<InfiniteList> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;

  _InfiniteListState() {
    _scrollController.addListener(_onScroll);
    _postBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _postBloc,
      builder: (BuildContext context, PostState state) {
        if (state is PostUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(
                      post: state.posts[index],
                    );
            },
            itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }
}
