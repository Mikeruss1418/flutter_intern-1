import 'package:flutter/material.dart';

class Customscroll extends StatefulWidget {
  const Customscroll({super.key});

  @override
  State<Customscroll> createState() => _HomeState();
}

class _HomeState extends State<Customscroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('ScrollView'),
      ),
      body: CustomScrollView(
        slivers: [
          //
          const SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 160, // it sets the
            backgroundColor: Colors.green,
            pinned: true, //pins the title
            //expandedHeight: 150, //sets the height of the appbar when expanded
            // title: const Text(
            //   'SliverAppbar',
            // ),
            //this title is found at the top with no animation
            flexibleSpace: FlexibleSpaceBar(
              title: Text('SLiverList', style: TextStyle(color: Colors.black)),
            ),
          ),
          //
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (context, index) {
                return ListTile(title: Text('Item ${index + 1}'));
              },
            ),
          ),

          //this provides padding to the next widget

          const SliverAppBar(
            primary: true,
            pinned: true,
            automaticallyImplyLeading: false,
            title: Text(
              'ListView.Builder',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 20)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 600,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      //provides gap between the titles and other like trailing/leading
                      leading: const Icon(Icons.account_circle_rounded),
                      title: Text('Person ${index + 1}'),
                      subtitle: const Text('Phone No....'),
                    );
                  },
                  itemCount: 10),
            ),
          ),

          const SliverFillRemaining(
            hasScrollBody: false, //this is to stop the overscroll
            fillOverscroll: true,
            child: Center(child: Text("This is End")),
          )
          // SliverList(
          //     delegate:
          //         SliverChildBuilderDelegate(childCount: 20, (context, index) {
          //   return ListTile(title: Text('Item ${20 + index + 1}'));
          // }))
        ],
      ),
    );
  }
}
