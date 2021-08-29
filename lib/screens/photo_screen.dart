import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_search/networking/unsplash_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const ACCESS_KEY = "VrezgKqPoxoT2Jg1ayiwnUH923HOIsYENQbi0xiYlro";

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final _pagingController =
      PagingController<int, UnsplashResults>(firstPageKey: 1);

  String searchTerm = "cat";

  Future<List<UnsplashResults>> getData(int page, String searchTerm) async {
    String url =
        "https://api.unsplash.com/search/photos/?query=$searchTerm&page=$page&per_page=10&client_id=$ACCESS_KEY";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      UnsplashResponse unsplashResponse =
          UnsplashResponse.fromJson(jsonDecode(response.body));
      List<UnsplashResults> results = unsplashResponse.results!;
      return results;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await getData(pageKey, searchTerm);

      final nextPageKey = pageKey + 1;

      _pagingController.appendPage(newPage, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Image App"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String? newSearchTerm = await showSearch<String>(
                    context: context, delegate: DataSearch());
                if (newSearchTerm != null) {
                  if (newSearchTerm.trim().isNotEmpty) {
                    searchTerm = newSearchTerm;
                    _pagingController.refresh();
                  }
                }
              },
            ),
          ],
        ),
        body: PagedListView<int, UnsplashResults>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<UnsplashResults>(
            itemBuilder: (context, item, index) => Card(
              elevation: 8,
              child: Container(
                height: height * 0.4,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item.urls?.regular ?? "",
                  placeholder: (context, url) =>
                      Icon(Icons.image, size: height * 0.3),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image_not_supported, size: height * 0.3),
                ),
              ),
            ),
          ),
        ));
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            close(context, query);
          },
          icon: Icon(Icons.search)),
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    close(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
