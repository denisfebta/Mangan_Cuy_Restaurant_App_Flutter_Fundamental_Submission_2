import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_denis/common/style.dart';
import 'package:restaurant_denis/data/api/api_service.dart';
import 'package:restaurant_denis/provider/restaurant_detail_provider.dart';

class DetailPage extends StatelessWidget {
  String restaurant;
  DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: restaurant),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.Error) {
              return Center(child: Text("failed get data"));
            } else if (state.result == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 200,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/" +
                                state.result.restaurant.pictureId,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        backgroundColor: mainColor,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.arrow_back,
                                    color: firstColor)
                            )
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              state.result.restaurant.name,
                              style: font1.copyWith(fontSize: 24),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 3),
                            child: Row(
                              children: List<Widget>.generate(
                                  5,
                                      (index) => Icon(
                                    (index < state.result.restaurant.rating.round())
                                        ? Icons.star
                                        : Icons.star_outline,
                                    size: 16,
                                    color: thirdColor,
                                  )) +
                                  [
                                    SizedBox(width: 4,),
                                    Text(
                                      state.result.restaurant.rating.toString(),
                                    )
                                  ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.pin_drop),
                              Text(state.result.restaurant.city)
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Description',
                                style: font1.copyWith(fontSize: 15),
                              )),
                          Text(
                            state.result.restaurant.description,
                            textAlign: TextAlign.justify,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Menu',
                                style: font1.copyWith(fontSize: 15),
                              )),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Foods',
                                style: font1.copyWith(fontSize: 15),
                              )),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.result.restaurant.menus.foods
                                  .map((e) => Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: fourthColor,
                                    borderRadius: BorderRadius.all(Radius.circular(15)
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.name,
                                        textAlign: TextAlign.center,
                                        style: font2,
                                        maxLines: 1,
                                      ),
                                    ],
                                  )))
                                  .toList(),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Drinks',
                                style: font1.copyWith(fontSize: 15),
                              )),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.result.restaurant.menus.drinks
                                  .map((e) => Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: fourthColor,
                                    borderRadius: BorderRadius.all(Radius.circular(15)
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.name,
                                        textAlign: TextAlign.center,
                                        style: font2,
                                        maxLines: 1,
                                      ),
                                    ],
                                  )
                              )
                              )
                                  .toList(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                                "Penilaian Pelanggan",
                                style: font1.copyWith(fontSize: 15),
                              ),
                          ),
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: state.result.restaurant.customerReviews
                                    .map((review) => ListTile(
                                  leading: Icon(
                                    Icons.chat_bubble,
                                    size: 40,
                                  ),
                                  title: Text(review.name),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('"${review.review}"'),
                                        Text("date: " + review.date),
                                      ]),
                                  isThreeLine: true,
                                )
                              )
                              .toList(),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}