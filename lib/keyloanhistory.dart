
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

import 'header_footer.dart';
import 'homepage.dart';
import 'login.dart';

class KeyLoanHistory extends StatefulWidget {
  const KeyLoanHistory({super.key, required this.title,});
  final String title;

  @override
  State<KeyLoanHistory> createState() => _KeyLoanHistoryState();
}

class _KeyLoanHistoryState extends State<KeyLoanHistory> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  TextEditingController searchController = TextEditingController();
  late ScrollController scrollController;
  bool showFAB = false;

  //Temp record created just to test the layout of the cards
  Record testRecord = Record(
    keyCode: 'SO2os02DAprmpaatr1po',
    visitorName: 'Harry Owen',
    visitorEmail: 'harry@vipower.co.uk',
    visitorCompany: 'Vipower Limited',
    visitorPhoneNo: '02582919284',
    keyTag: 'Riser Key',
    keyNumber: 24,
    issueTime: DateTime.now(),
    returnTime: DateTime.utc(2022, 1, 1, 1, 1, 1, 1),
  );

  Record testRecord2 = Record(
    keyCode: '092mf01AJFf9812mn',
    visitorName: 'David Davies',
    visitorEmail: 'david@pcpowerltd.co.uk',
    visitorCompany: 'PCPowerLTD',
    visitorPhoneNo: '02894929480',
    keyTag: 'Lower Ground Fusebox',
    keyNumber: 12,
    issueTime: DateTime.now(),
    returnTime: DateTime.utc(2022, 1, 1, 1, 1, 1, 1),
  );

  Record testRecord3 = Record(
      keyCode: '109DA2poadOJF',
      visitorName: 'Phillip Monk',
      visitorEmail: 'phill@vipower.co.uk',
      visitorCompany: 'Vipower Limited',
      visitorPhoneNo: '10048204940',
      keyTag: '2nd Floor Bathroom',
      keyNumber: 01,
      issueTime: DateTime.now(),
      returnTime: DateTime.utc(2022, 1, 1, 1, 1, 1, 1),
  );

  List<Record> allRecords = [];
  List<Record> searchResults = [];

  @override
  void initState() {
    super.initState();
    allRecords.add(testRecord);
    allRecords.add(testRecord2);
    allRecords.add(testRecord3);

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
    List<Record> showResults = [];

    if (searchController.text.isNotEmpty) {
      for (var record in allRecords) {
        var name = record.visitorName!.toLowerCase();
        var keyName = record.keyTag!.toLowerCase();

        if (name.contains(searchController.text.toLowerCase()) || keyName.contains(searchController.text.toLowerCase())) {
          showResults.add(record);
          log('Record added to list');
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


  Widget displayCard(Record record) {
    int timeHeld = record.issueTime!.difference(record.returnTime!).inSeconds;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(flex: 1, child: Text(record.keyTag!, style: const TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,)),
                        Flexible(flex:1, child: Text(record.visitorName!, style: const TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,),)
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
                      Text('Email Address:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(record.visitorEmail!, style: contentStyle, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8.0,),
                      Text('Phone Number:', style: headerStyle, overflow: TextOverflow.ellipsis),
                      Text(record.visitorPhoneNo!, style: contentStyle, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8.0,),
                      Text('Company:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(record.visitorCompany!, style: contentStyle, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8.0),
                      Text('Number:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(record.keyNumber!.toString(), style: contentStyle, overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                const SizedBox(width: 24.0,),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Key Issued:', style: headerStyle, overflow: TextOverflow.ellipsis,),
                      Text(record.issueTime!.toString(), style: contentStyle, overflow: TextOverflow.clip,),
                      const SizedBox(height: 8.0,),
                      Text('Key Returned:', style: headerStyle, overflow: TextOverflow.ellipsis),
                      Text(record.returnTime!.toString(), style: contentStyle, overflow: TextOverflow.clip,),
                      const SizedBox(height: 8.0),
                      Text('Time Held:', style: headerStyle, overflow: TextOverflow.ellipsis),
                      Text(timeHeld.toString(), style: contentStyle, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Request Return',),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCardList(List<Record> records) {
    List<Widget> outstandingJobsCards = [];

    for (Record i in records) {
      outstandingJobsCards.add(displayCard(i));
      outstandingJobsCards.add(const SizedBox(height: 24.0,));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: outstandingJobsCards,
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
          physics: NeverScrollableScrollPhysics(),
          children: [
            header(),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text('Now viewing outstanding keys at $buildingName. There are ${allRecords.length} keys awaiting return.', style: const TextStyle(color: Colors.black38), textAlign: TextAlign.center,),
                    searchBar(),
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