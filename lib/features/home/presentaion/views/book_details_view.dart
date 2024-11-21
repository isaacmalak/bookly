import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bookly/core/utils/custom_error_widget.dart';
import 'package:my_bookly/core/utils/service_locator.dart';
import 'package:my_bookly/core/utils/styles.dart';
import 'package:my_bookly/features/home/data/models/book_model/book_model.dart';
import 'package:my_bookly/features/home/data/repos/home_repo_implementaion.dart';
import 'package:my_bookly/features/home/presentaion/manager/related_books_cubit/related_books_cubit_cubit.dart';
import 'package:my_bookly/features/home/presentaion/views/widgets/newest_book_details_item.dart';
import 'package:my_bookly/features/home/presentaion/views/widgets/books_items_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({
    super.key,
    required this.myBook,
  });
  // final String category;
  final BookModel myBook;
  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  late RelatedBooksCubit relatedBooksCubit;
  // ToDo : try to make the cubit with it`s constructor
  @override
  void initState() {
    // BlocProvider.of<RelatedBooksCubit>(context)
    //     .fetchRelatedBooks(widget.myBook.volumeInfo.categories![0]);
    relatedBooksCubit = RelatedBooksCubit(getIt.get<HomeRepoImplementation>())
      ..fetchRelatedBooks(category: widget.myBook.volumeInfo.categories![0]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => relatedBooksCubit,
      child: BlocBuilder<RelatedBooksCubit, RelatedBooksState>(
          builder: (context, state) {
        if (state is RelatedBooksSuccess) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Icon(Icons.close),
                ),
              ),
              backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.1,
                          ),
                          child: BookItem(
                            imageUrl: widget
                                    .myBook.volumeInfo.imageLinks?.thumbnail ??
                                '2',
                          )),
                      const SizedBox(height: 27),
                      Text(
                        textAlign: TextAlign.center,
                        widget.myBook.volumeInfo.title.toString(),
                        style: const TextStyle(
                            overflow: TextOverflow.visible,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      // Text(widget.myBook.volumeInfo.authors![0],
                      //     style: Styles.textFine.copyWith(fontSize: 13)),
                      if (widget.myBook.volumeInfo.authors == null) ...{
                        Text('No Authors',
                            style: Styles.textFine.copyWith(fontSize: 13))
                      } else ...{
                        Container(
                          child: ListView.builder(
                            itemCount: widget.myBook.volumeInfo.authors!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Text(
                                widget.myBook.volumeInfo.authors![index],
                                style: Styles.textFine.copyWith(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),

                        // for (var author in widget.myBook.volumeInfo.authors!) ...{
                        //   Text(
                        //     author,
                        //     style: Styles.textFine.copyWith(fontSize: 13),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // }
                      },
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BookRating(
                            rating: widget.myBook.volumeInfo.averageRating!,
                            number: widget.myBook.volumeInfo.ratingCount!,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 48,
                            width: 130,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  color: Color(0xFFEF8262),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Uri url = Uri.parse(
                                  widget.myBook.volumeInfo.previewLink!);
                              if (!await launchUrl(url)) {
                                throw 'Could not launch ${widget.myBook.volumeInfo.previewLink}';
                              }
                            },
                            child: Container(
                              height: 48,
                              width: 130,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF8262),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Preview',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            'You Can Also Like',
                            style: Styles.titleMedium.copyWith(fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 100,
                        child: state.booksList.isEmpty
                            ? const Center(
                                child: Text('No Related Books'),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .267,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.booksList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: BookItem(
                                        imageUrl: state
                                                .booksList[index]
                                                .volumeInfo
                                                .imageLinks
                                                ?.thumbnail ??
                                            '2',
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is RelatedBooksFailed) {
          return Scaffold(
              body: CustomErrorWidget(errorMessage: state.errorMessage));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
