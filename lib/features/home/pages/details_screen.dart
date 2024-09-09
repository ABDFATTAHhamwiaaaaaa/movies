

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/core/unified_api/status.dart';
import 'package:movizone/features/home/pages/widget/cast_widget.dart';
import 'package:movizone/features/home/pages/widget/review_widget.dart';

import '../../witshlist/bloc/wishlist_bloc.dart';
import '../bloc/home_bloc.dart';

class MoviesDetailsScreen extends StatefulWidget {
  final String id;

  MoviesDetailsScreen({super.key, required this.id});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetDetadilsEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Details'),
                  centerTitle: true,
                  leading: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios_new),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: InkWell(
                        child: const Icon(Icons.bookmark),
                        onTap: () {
                          if(state.movieDetails!=null)
                         context.read<WishlistBloc>().add(AddWishlistEvent(movie: state.movieDetails!));
                        },
                      ),
                    ),
                  ],
                ),
                body: switch (state.detailsStatus) {
                  Status.success => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .4,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .3,
                                        child: Image.network(
                                          ApiVariables().imageBaseUrl +
                                              state.movieDetails!.backdropPath!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .3,
                                        ),
                                      ),
                                    ).animate().slideX(),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 30,
                                bottom: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(18)),
                                        child: Image.network(
                                          ApiVariables().imageBaseUrl +
                                              state.movieDetails!.posterPath!,
                                          height: 160,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )).animate().slideY(),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width * .5,
                                      child: Text(
                                        state.movieDetails!.title!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              ).animate().fade()
                            ],
                          ),
                          SizedBox(
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset('assets/calendar.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.movieDetails!.releaseDate!.year
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                                SvgPicture.asset('assets/clock.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.movieDetails!.runtime.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                                SvgPicture.asset('assets/ticket.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.movieDetails!.genres!.first.name!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ).animate().scale(),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TabBar(
                            tabs: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text('About Movei'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // if(state.reviewsStatus!=Status.success){
                                  //   context.read<HomeBloc>().add(GetReviwesEvent(widget.id));
                                  // }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text('Reviews'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // if(state.creditsStatus!=Status.success){
                                  //   context.read<HomeBloc>().add(GetCreditsEvent(widget.id));
                                  // }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text('Cast'),
                                ),
                              ),
                            ],
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                            splashBorderRadius: BorderRadius.circular(15),
                            dividerHeight: 0,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            indicatorColor: Colors.grey,
                            labelStyle: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * .4,
                              child: TabBarView(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.movieDetails!.overview!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ).animate().fade(),
                                ReviewWidget(state: state,).animate().fade(),
                                CastWidget(state: state,).animate().fade(),
                              ])),
                        ],
                      ),
                    ),
                  Status.failed => ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(GetDetadilsEvent(widget.id));
                      },
                      child: Text('Try Again')).animate().fade(),
                  _ => Center(child: CircularProgressIndicator()).animate().fade()
                }),
          );
        },
      ),
    );
  }
}
