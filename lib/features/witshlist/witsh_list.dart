import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/features/witshlist/bloc/wishlist_bloc.dart';

import '../../core/widgets/about_me.dart';

class WitshListScreen extends StatelessWidget {
  WitshListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('WishList'),
            centerTitle: true,
            actions: const [AboutMeIcon()],
          ),
          body: state.wishlistMovie.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: Image.asset('assets/wishlist.png'),
                      ).animate().fade(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'There is No movie yet!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ).animate().fade(),
                      Text(
                        'Find your movie by Type title, categories, years, etc',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ).animate().fade()
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.wishlistMovie.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          context.read<WishlistBloc>().add(RemoveWishlistEvent(
                              id: state.wishlistMovie[index].id!));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: ClipRRect(
                                  child: Image.network(
                                    ApiVariables().imageBaseUrl +
                                        state.wishlistMovie[index].posterPath!,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 120,
                                width: 80,
                              ).animate().slideX(),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.wishlistMovie[index].title!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ).animate().fade(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/star.svg'),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              state.wishlistMovie[index]
                                                  .voteAverage!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ).animate().slideY(),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/ticket.svg'),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              state.wishlistMovie[index].genres!
                                                  .first.name!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ).animate().slideY(),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/clock.svg'),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              '${state.wishlistMovie[index].runtime} Minutes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ).animate().slideY(),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/calendar.svg'),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              state.wishlistMovie[index]
                                                  .releaseDate!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ).animate().slideY(),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
