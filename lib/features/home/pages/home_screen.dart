import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/core/unified_api/status.dart';
import 'package:movizone/features/home/pages/widget/list_item.dart';
import 'package:movizone/features/home/pages/widget/select_categor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/widgets/about_me.dart';
import '../bloc/home_bloc.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var felse;

  final PageController _pageController = PageController(
    initialPage: 0,
  );
  final ValueNotifier<int> selectGenre = ValueNotifier(0);
  var pageController = PageController(
    initialPage: 2,
    viewportFraction: .8,
  );

  @override
  void initState() {
    Timer.periodic(Durations.extralong4 * 5, (timer) {
      pageController.animateToPage(pageController.page!.toInt() + 1,
          duration: Durations.long1, curve: Curves.easeIn);
    });
    context.read<HomeBloc>().add(Getcategories());
    context.read<HomeBloc>().add(GetTopRated());
    context.read<HomeBloc>().add(GetmoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff12cdd9),
            child: SvgPicture.asset('assets/about.svg'),
            onPressed: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return const AboutMeDialog();
                  });
            }),
        body:SafeArea(child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18, top: 25),
              child: Text(
                'What do you want to watch?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ).animate().fade(),
            SizedBox(
              height: 220,
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return switch (state.topRatedStatus) {
                          Status.failed => ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(GetTopRated());
                            },
                            child: Text('Try Again'),
                          ).animate().fade(),
                          Status.success => PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MoviesDetailsScreen(
                                        id: state.topRated[index % 5].id!
                                            .toString());
                                  }),
                                );
                              },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListItemA(
                                    image: ApiVariables().imageBaseUrl +
                                        state.topRated[index % 5].backdropPath!,
                                    nameMoveiz: state.topRated[index % 5].title!,
                                  ),
                                ).animate().fade(),
                              );
                            },
                          ),
                          _ => Center(child: CircularProgressIndicator()).animate().fade()
                        };
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 5,
                    effect: ExpandingDotsEffect(
                      dotColor: const Color(0xff12CDD9).withOpacity(.5),
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 20,
                      activeDotColor: const Color(0xff12CDD9),
                    ),
                  ).animate().fade(),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ).animate().fade(),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) {
                return previous.categoriesStatus != current.categoriesStatus;
              },
              builder: (context, state) {
                return switch (state.categoriesStatus) {
                  Status.failed => Center(
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(Getcategories());
                        },
                        child: Text('Try Again')).animate().fade(),
                  ),
                  Status.success => Container(
                    padding: EdgeInsets.only(left: 15, bottom: 4),
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: ValueListenableBuilder(
                      valueListenable: selectGenre,
                      builder: (BuildContext context, value, _) {
                        return ListView.builder(
                          itemCount: state.genres.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectGenre.value = index;

                              if (index == 0) {
                                context
                                    .read<HomeBloc>()
                                    .add(GetmoviesEvent());
                              } else {
                                context.read<HomeBloc>().add(GetmoviesEvent(
                                    genreid:
                                    state.genres[index-1].id!.toString()));
                              }
                            },
                            child: SelectedCategoryWidget(
                              title: index == 0
                                  ? 'All'
                                  : state.genres[index - 1].name!,
                              isSelected: index == value,
                            ).animate().fade(),
                          ),
                        );
                      },
                    ),
                  ),
                  _ => Center(child: CircularProgressIndicator()).animate().fade(),
                };
              },
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) {
                  return previous.moviesStatue != current.moviesStatue;
                },
                builder: (context, state) {
                  return switch (state.moviesStatue) {
                    Status.failed => ElevatedButton(
                        onPressed: () {
                          if (selectGenre.value == 0) {
                            context.read<HomeBloc>().add(GetmoviesEvent());
                          } else {
                            context.read<HomeBloc>().add(GetmoviesEvent(
                                genreid: state.genres[selectGenre.value - 1].id!
                                    .toString()));
                          }
                        },
                        child: Center(child: Text('Try Again'))).animate().fade()  ,
                    Status.success => GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: state.movies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .8,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) => ClipRRect(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MoviesDetailsScreen(
                                            id: '',
                                          ),
                                    ));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                    ApiVariables().imageBaseUrl +
                                        state.movies[index].posterPath!),
                              )),
                          borderRadius: BorderRadius.circular(20)),
                    ).animate().fade(),
                    _ => Center(child: CircularProgressIndicator()).animate().fade()
                  };
                },
              ),
            )
          ],
        )),
      
    );
  }
}
