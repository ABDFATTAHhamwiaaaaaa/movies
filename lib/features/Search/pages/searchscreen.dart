import 'dart:async';
import 'dart:math';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/core/unified_api/status.dart';
import 'package:flutter/animation.dart';
import '../../../core/widgets/about_me.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  Timer? searchTimer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 18.0),
            //   child: InkWell(
            //     child: SvgPicture.asset('assets/about.svg'),
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            AboutMeIcon(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      onChanged: (value) {
                        if (searchTimer?.isActive ?? false) {
                          searchTimer?.cancel();
                        } else {
                          searchTimer = Timer(Duration(milliseconds: 750), () {
                            if (value.length >= 3) {
                              context
                                  .read<SearchBloc>()
                                  .add(searchMovieEvent(query: value));
                            }
                          });
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefix: GestureDetector(
                            onTap: () {
                              textController.clear();
                              context
                                  .read<SearchBloc>()
                                  .add(searchMovieEvent(query: ''));
                            },
                            child: Icon(Icons.close, color: Colors.white,)),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        hoverColor: Colors.white12,
                        contentPadding: EdgeInsets.all(15),
                        isCollapsed: true,
                        fillColor: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        filled: true,
                        suffixIconConstraints:
                            BoxConstraints.tight(const Size(50, 30)),
                        suffixIcon: Transform.flip(
                          flipX: true,
                          child: Row(
                            children: [
                              const Spacer(),
                              SvgPicture.asset(
                                'assets/search.svg',
                                width: 30,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: textController,
                    ).animate().slideX(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  state.status == Status.initial
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'Please Add Some Words To Search',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ).animate().fade(),
                          ),
                        )
                      : state.status == Status.loading
                          ? Center(child: CircularProgressIndicator()).animate().fade()
                          : state.status == Status.failed
                              ? Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context.read<SearchBloc>().add(
                                            searchMovieEvent(
                                                query: textController.text));
                                      },
                                      child: Text('Try Again')).animate().fade(),
                                )
                              : state.sreachResult.isEmpty
                                  ? Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 40,
                                              child: Image.asset(
                                                  'assets/noresult.png').animate().fade(),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'we are sorry, we can not find the movie :(',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ).animate().fade(),
                                            Text(
                                              'Find your movie by Type title, categories, years, etc ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ).animate().fade()
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                      itemCount: state.sreachResult.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                child: ClipRRect(
                                                  child: Image.asset(
                                                    ApiVariables()
                                                            .imageBaseUrl +
                                                        state
                                                            .sreachResult[index]
                                                            .posterPath!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ).animate().fade(),
                                                height: 120,
                                                width: 80,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.sreachResult[index]
                                                        .title!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ).animate().fade(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/star.svg').animate().fade(),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              state
                                                                  .sreachResult[
                                                                      index]
                                                                  .voteAverage
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ).animate().fade(),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/ticket.svg').animate().fade(),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              'Action',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/clock.svg').animate().fade(),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Random().nextInt(100) + 100} Minutes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/calendar.svg'),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              state
                                                                  .sreachResult[
                                                                      index]
                                                                  .releaseDate!
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ).animate().scaleY(),
                                        );
                                      },
                                    ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
