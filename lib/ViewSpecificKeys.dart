
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';
import 'package:test_qr_code/records_model.dart';

import 'allKeys_model.dart';
import 'header_footer.dart';
import 'homepage.dart';
import 'login.dart';

class ViewSpecificKeys extends StatefulWidget {
  const ViewSpecificKeys({super.key, required this.title,});
  final String title;

  @override
  State<ViewSpecificKeys> createState() => _ViewSpecificKeysState();
}

class _ViewSpecificKeysState extends State<ViewSpecificKeys> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  TextEditingController searchController = TextEditingController();
  late ScrollController scrollController;
  bool showFAB = false;

  //Temp keys created just to test the layout of the cards
  AllKeys key1 = AllKeys(
    keyCode: 'AFNaio12908noalAVCNL',
    buildingID: 'SDO2OD',
    colour: 'red',
    tag: 'Riser Key',
    status: false,
    number: 95
  );
  AllKeys key2 = AllKeys(
    keyCode: 'FANlo2nmoiafio',
    buildingID: 'SDO2OD',
    colour: 'green',
    tag: 'Riser Key',
    status: false,
    number: 2
  );
  AllKeys key3 = AllKeys(
    keyCode: 'pofianAFBin1',
    buildingID: 'SDO2OD',
    colour: 'black',
    tag: 'Riser Key',
    status: false,
    number: 1
  );
  AllKeys key4 = AllKeys(
    keyCode: 'Afnp12npofaonaf',
    buildingID: 'SDO2OD',
    colour: 'red',
    tag: 'Riser Key',
    status: false,
    number: 6,
  );

  List<AllKeys> allRecords = [];
  List<AllKeys> searchResults = [];

  @override
  void initState() {
    super.initState();
    allRecords.add(key1);
    allRecords.add(key2);
    allRecords.add(key3);
    allRecords.add(key4);

    //Add Listener to the search controller
    searchResults = List.from(allRecords);
    searchController.addListener(onSearchChanged);

    //Handle the scroll controller initialisation
    //This makes it so the floating action button for scrolling to top only shows after scrolling down far enough
    scrollController = ScrollController()..addListener(() { setState(() {
      if (scrollController.offset >= 400) {
        showFAB = true;
      }
      else {
        showFAB = false;
      }
    });});
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  onSearchChanged() {
    log('Search changed!');
    searchResultsList();
  }

  searchResultsList() {
    List<AllKeys> showResults = [];

    if (searchController.text.isNotEmpty) {
      for (var key in allRecords) {
        var tag = key.tag!.toLowerCase();

        if (tag.contains(searchController.text.toLowerCase())) {
          showResults.add(key);
          log('Key added to list');
        }
      }
    }
    else {
      showResults = List.from(allRecords);
    }

    setState(() {
      searchResults = showResults;
    });
  }

  Widget qrImage() {

    return Container(
      height: 150, width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(48, 153, 117, 1), width: 10.0),
          borderRadius: BorderRadius.circular(125),
          image: const DecorationImage(
            image: AssetImage('assets/images/qr2.bmp'),
            fit: BoxFit.scaleDown,
          )
      ),
    );
  }


  Widget displayCard(AllKeys key) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                offset: Offset(5.0, 5.0),
                blurRadius: 24.0
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: appColour()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                        alignment: Alignment.center, child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(flex: 1, child: Text(key.number!.toString(), style: const TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,)),
                        //Flexible(flex:1, child: Text(record.visitorName!, style: const TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,),)
                      ],
                    )
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Key Name:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(key.tag!, style: contentStyle, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8.0),
                      Text('Status:', style: headerStyle, overflow: TextOverflow.ellipsis),
                      Text(key.status! ? 'Claimed' : 'Unclaimed', style: contentStyle, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8.0),
                      Text('Key Colour:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(key.colour!, style: contentStyle, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
                const SizedBox(width: 24.0,),
                Flexible(
                  flex: 1,
                  child: qrImage()
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //Sends an email reminder to the visitor to inform them to return their key

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('Key History',),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Sends an email reminder to the visitor to inform them to return their key

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('Edit',),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Sends an email reminder to the visitor to inform them to return their key

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('Reprint Key',),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCardList(List<AllKeys> keys) {
    List<Widget> allKeysCard = [];

    for (AllKeys i in keys) {
      allKeysCard.add(displayCard(i));
      allKeysCard.add(const SizedBox(height: 24.0,));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: allKeysCard,
    );
  }

  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Search Keys:', style: TextStyle(color: Colors.black38,),),
        const SizedBox(width: 24.0,),
        SizedBox(
          width: 250,
          child: TextField(
            controller: searchController,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      backgroundColor: const Color.fromRGBO(234, 244, 255, 1),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: footer(context),
      body: SingleChildScrollView(
        controller: scrollController,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            header(),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text('There are ${allRecords.length} keys for ${allRecords[0].tag}.', style: const TextStyle(color: Colors.black38), textAlign: TextAlign.center,),
                    //searchBar(),
                    const Divider(),
                    const SizedBox(height: 12.0,),
                    buildCardList(searchResults),
                  ],
                )
            )
          ],
        ),
      ),
      floatingActionButton: showFAB == false ? null : FloatingActionButton(
        onPressed: () {
          log('To the top!');
          scrollToTop();
        },
        backgroundColor: appColour(),
        child: const Icon(Icons.arrow_upward, color: Colors.white,),
      ),
    );
  }
}