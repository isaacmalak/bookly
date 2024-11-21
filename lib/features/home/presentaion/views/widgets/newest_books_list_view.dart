import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bookly/core/utils/assets.dart';
import 'package:my_bookly/core/utils/custom_error_widget.dart';
import 'package:my_bookly/features/home/presentaion/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:my_bookly/features/home/presentaion/views/widgets/newest_book_details_item.dart';

class NewestBooksListView extends StatelessWidget {
  const NewestBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: state.booksList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: NewestBookDetailsItem(
                    bookModel: state.booksList[index],
                    imageUrl: state.booksList[index].volumeInfo.imageLinks
                            ?.thumbnail ??
                        '2',
                  ),
                );
              },
            ),
          );
        } else if (state is NewestBooksFailed) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
