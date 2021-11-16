import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_denis/common/style.dart';
import 'package:restaurant_denis/provider/restaurant_provider.dart';
import 'package:restaurant_denis/widget/card_restaurant.dart';

class ListAppPage extends StatefulWidget {
  const ListAppPage({Key? key}) : super(key: key);

  @override
  State<ListAppPage> createState() => _ListAppPageState();
}

class _ListAppPageState extends State<ListAppPage> {
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    Consumer<RestaurantProvider>(builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    //loading widget
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.Error) {
                    // error widget
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Connection failed",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: mainColor),
                          ),
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    // error No Data
                    return Center(child: Text(state.message));
                  } else if (state.state == ResultState.HasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: state.result.count,
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants[index];
                          return CardRestaurant(restaurant: restaurant);
                        });
                  } else {
                    return Text("");
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
