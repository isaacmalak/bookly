import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_bookly/core/utils/assets.dart';
import 'package:my_bookly/core/utils/styles.dart';
import 'package:my_bookly/features/home/presentaion/views/widgets/newest_books_list_view.dart';
import 'package:my_bookly/features/home/presentaion/views/widgets/books_items_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 70),
                  child: CustomAppBar()),
              SizedBox(height: 18),
              BookItemsListView(),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Newest books',
                  style: Styles.titleMedium,
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: NewestBooksListView(),
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetsData.logo,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                GoRouter.of(context).push('/search_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
