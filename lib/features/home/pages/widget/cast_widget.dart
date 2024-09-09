import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movizone/features/home/bloc/home_bloc.dart';

import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/status.dart';

class CastWidget extends StatelessWidget {
  CastWidget({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return switch (state.creditsStatus) {
      Status.success =>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: state.cast.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) =>
                Column(
                    children: [
                CircleAvatar(
                backgroundImage: NetworkImage(state.cast
                    [index].profilePath==null? 'http://www.gravatar.com/avatar':
                    ApiVariables().imageBaseUrl +
                    state.cast[index].profilePath!),
            radius: 60,
          ),
    SizedBox(
    height: 7,
    ),
    Text(
    state.cast[index].name!,
    style: TextStyle(color: Colors.white),
    )
    ],
    ),
    ).animate().fade(),
    ),
    Status.failed => ElevatedButton(
    onPressed: () {
    context.read<HomeBloc>().add(GetDetadilsEvent(state.movieDetails!.id!.toString()));
    },
    child: Center(child: Text('Try Again'))).animate().fade(),
    _ => Center(child: CircularProgressIndicator()).animate().fade()
    };
  }
}
