import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_bookly/core/utils/styles.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';

class NewestBookDetailsItem extends StatelessWidget {
  const NewestBookDetailsItem({
    required this.imageUrl,
    super.key,
    required this.bookModel,
  });
  final String imageUrl;
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/book_details_page', extra: bookModel);
      },
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              height: 130,
              width: 100,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.scaleDown,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported_outlined),
              ),
            ),
            const SizedBox(width: 10), // Space between image and column
            Expanded(
              // Ensure the column uses the remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.volumeInfo.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Styles.textRegular,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      bookModel.volumeInfo.authors?.first ?? 'No authors',
                      textAlign: TextAlign.start,
                      style: Styles.textMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('FREE', style: Styles.textBold),
                      BookRating(
                        rating: bookModel.volumeInfo.averageRating!,
                        number: bookModel.volumeInfo.ratingCount!,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookRating extends StatelessWidget {
  const BookRating({super.key, required this.rating, required this.number});
  final num rating;
  final num number;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
        Text(rating.toString(), style: Styles.textRegular),
        const SizedBox(width: 8),
        Text(number.toString(), style: Styles.textFine),
      ],
    );
  }
}
