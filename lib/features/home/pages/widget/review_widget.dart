import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movizone/features/home/bloc/home_bloc.dart';

import '../../../../core/unified_api/status.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return switch (state.reviewsStatus) {
      Status.success => ListView.builder(
          itemCount: state.review.length,
          itemBuilder: (context, index) => Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(state.review[index].url!??'https://'),
                ),
                title: Text(
                  state.review[index].author!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle: Text(
                  state.review[index].content!,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
              Divider(
                endIndent: 20,
                indent: 20,
                color: Colors.white,
                thickness: 1,
              )
            ],
          ),
        ).animate().fade(),
      Status.failed => ElevatedButton(
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(GetDetadilsEvent(state.movieDetails!.id!.toString()));
          },
          child: Text('Try Again')).animate().fade(),
      _ => Center(child: CircularProgressIndicator()).animate().fade()
    };
  }
}
