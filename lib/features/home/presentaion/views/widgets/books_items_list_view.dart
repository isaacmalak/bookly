import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bookly/core/utils/custom_error_widget.dart';
import 'package:my_bookly/features/home/presentaion/manager/featured_books_cubit/featured_books_cubit_cubit.dart';

class BookItemsListView extends StatelessWidget {
  const BookItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksCubitState>(
      builder: (context, state) {
        if (state is FeaturedBooksCubitSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .267,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.booksList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: BookItem(
                      imageUrl: state.booksList[index].volumeInfo.imageLinks
                              ?.thumbnail ??
                          '2',
                    ));
              },
            ),
          );
        } else if (state is FeaturedBooksCubitFailed) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: AspectRatio(
          aspectRatio: 2.7 / 4,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) {
              return const Center(
                child: Icon(Icons.image_not_supported_outlined),
              );
            },
          )),
    );
  }
}
