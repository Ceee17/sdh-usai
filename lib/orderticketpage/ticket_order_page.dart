import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/featured_data.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/widgets/card.dart';
import 'package:uas/widgets/grid.dart';
import 'package:uas/widgets/modal.dart';

class OrderTicketPage extends StatefulWidget {
  const OrderTicketPage({super.key});

  @override
  State<OrderTicketPage> createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 1 - 125;
    double cardHeight = 175;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Ticket',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured',
                style: headerText(18),
              ),
              h(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: featured.map((data) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: cardWidth,
                        height: cardHeight,
                        child: GestureDetector(
                          onTap: () {
                            showFeaturedDetails(context, data, data.title);
                          },
                          child: FeaturedCard(
                            data.imageUrl,
                            data.title,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              h(20),
              Text(
                'Most Picked',
                style: headerText(18),
              ),
              h(10),
              buildZoneGrid(context, zoneData, 'ticketPage'),
            ],
          ),
        ),
      ),
    );
  }
}
