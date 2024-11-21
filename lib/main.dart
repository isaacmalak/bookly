import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bookly/core/utils/constants.dart';
import 'package:my_bookly/core/utils/service_locator.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo_implementaion.dart';
import 'package:my_bookly/features/home/presentaion/manager/featured_books_cubit/featured_books_cubit_cubit.dart';
import 'package:my_bookly/features/home/presentaion/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:my_bookly/features/home/presentaion/manager/related_books_cubit/related_books_cubit_cubit.dart';
import 'package:my_bookly/features/home/presentaion/views/book_details_view.dart';
import 'package:my_bookly/features/home/presentaion/views/howe_view.dart';
import 'package:my_bookly/features/search/presentation/views/search.dart';
import 'package:my_bookly/features/splash/presentation/view/splash_view.dart';

void main() {
  setup();
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FeaturedBooksCubit(
              getIt.get<HomeRepoImplementation>(),
            )..fetchFeaturedBooks();
          },
        ),
        BlocProvider(
          create: (context) {
            return NewestBooksCubit(
              getIt.get<HomeRepoImplementation>(),
            )..fetchNewestBooks();
          },
        ),
      
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Bookly',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.spectralScTextTheme(
            ThemeData.dark().textTheme,
          ),
          scaffoldBackgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashView();
      },
    ),
    GoRoute(
        path: '/home_page',
        builder: (context, state) {
          return const HomeView();
        }),
    GoRoute(
        path: '/book_details_page',
        builder: (context, state) {
          return BookDetailsView(
            myBook: state.extra as BookModel,
          );
        }),
    GoRoute(
        path: '/search_page',
        builder: (context, state) {
          return const SearchView();
        })
  ],
);
