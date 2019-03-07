import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              "Sliver App Bar",
              style: TextStyle(color: Colors.white),
            ),
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Sliver App Bar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset('lib/assets/images/loading.gif'),
                  ),
                  Container(
                    width: double.infinity,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: 'https://mocah.org/uploads/posts/4576922-children-dog-animals-shiba-inu-running.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 200,
          ),
          SliverPersistentHeader(
            delegate: _TabBarDelegate(TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.info),
                  text: "Info",
                ),
                Tab(
                  icon: Icon(Icons.lightbulb_outline),
                  text: "Lightbulb",
                )
              ],
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.grey,
            )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            }, childCount: 1000),
          ),
        ]),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DefaultTabController(length: 2, child: _tabBar);
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
