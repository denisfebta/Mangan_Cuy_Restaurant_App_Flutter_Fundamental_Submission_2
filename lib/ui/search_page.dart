import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_denis/common/style.dart';
import 'package:restaurant_denis/provider/restaurant_search_provider.dart';
import 'package:restaurant_denis/widget/card_restaurant_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queries = '';
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mangan Cuy',
            style: font1,
          ),
          backgroundColor: mainColor,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Consumer<SearchRestaurantProvider>(
                builder: (context, state, _) {
                  return Container(
                      decoration: BoxDecoration(
                          color: firstColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                          leading: Icon(
                            Icons.search,
                            size: 30,
                            color: thirdColor,
                          ),
                          title: TextField(
                            controller: _controller,
                            onChanged: (String value) {
                              setState(() {
                                queries = value;
                              });
                              if (value != '') {
                                state.fetchAllRestaurantSearch(value);
                              }
                            },
                            cursorColor: mainColor,
                            decoration: InputDecoration(hintText: "Looking for restaurant?", border: InputBorder.none),
                          ),
                          trailing: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              if (queries != '') {
                                _controller.clear();
                                setState(() {
                                  queries = '';
                                });
                              }
                            },
                            icon: Icon(Icons.cancel_outlined, size: 30),
                          )));
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _listSearchRestaurants(context),
                ),
              ),
              
            ],
          ),
        ));
  }

  Widget _listSearchRestaurants(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == StateResultSearch.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == StateResultSearch.HasData) {
          return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.result!.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result!.restaurants[index];
                  return CardRestaurantSearch(restaurant: restaurant);
                },
              ));
        } else if (state.state == StateResultSearch.NoData) {
          return Center(
              child: Text(
            state.message,
            style: TextStyle(color: mainColor),
          ));
        } else if (state.state == StateResultSearch.Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/food-app-interaction.json',
                  height: 230,
                ),
                Text(
                  "Let's find your Restaurant",
                  textAlign: TextAlign.center,
                  style: font4,
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}