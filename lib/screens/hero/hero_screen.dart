import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_hero/blocs/hero_bloc.dart';
import 'package:super_hero/models/hero.dart';
import 'package:super_hero/repository/hero_repository.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HeroScreen extends StatefulWidget {
  HeroScreen();

  @override
  _HeroScreenState createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  final HeroBloc _bloc = HeroBloc(HeroRepository());
  List<HeroModel> _heroes;
  int _focusedIndex = 0;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 40),
        child: StreamBuilder<AppBarState>(
          initialData: AppBarState.IDLE,
          stream: _bloc.appBarStream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case AppBarState.IDLE:
                return AppBar(
                  title: Text('Superhero app'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _bloc.toggleAppBar(AppBarState.SEARCH),
                    )
                  ],
                );
              default:
                return AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => _bloc.toggleAppBar(AppBarState.IDLE),
                  ),
                  title: TextField(
                    onChanged: (value) => setState(() {}),
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Procurar..',
                    ),
                  ),
                  actions: [
                    Visibility(
                      visible: _searchController.text.length > 0,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await _bloc.getList(_searchController.text);

                          _focusedIndex = 0;
                        },
                      ),
                    ),
                    Visibility(
                      visible: _searchController.text.length > 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => _searchController.clear(),
                      ),
                    )
                  ],
                );
            }
          },
        ),
      ),
      body: Container(
        child: StreamBuilder<ResultState>(
          initialData: ResultState.IDLE,
          stream: _bloc.listStream,
          builder: (context, snapshot) {
            _heroes = _bloc.results;
            switch (snapshot.data) {
              case ResultState.LOADED:
                return Column(
                  children: [
                    Expanded(
                      child: ScrollSnapList(
                        onItemFocus: _onItemFocus,
                        itemSize: 200,
                        itemBuilder: _buildListItem,
                        itemCount: _heroes.length,
                        dynamicItemSize: true,
                      ),
                    ),
                    _buildItemDetail(),
                  ],
                );

              case ResultState.EMPTY:
                return Center(child: Text('Nenhum registro encontrado'));
                break;
              case ResultState.IDLE:
                return Center(
                    child: Text('Realize uma busca para exibir resultados'));
                break;
              case ResultState.LOADING:
              default:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildItemDetail() {
    return Container(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _heroes[_focusedIndex].name,
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
          Text(
            "#${_heroes[_focusedIndex].id}",
            style: TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/heroDetail',
          arguments: _heroes[index]),
      child: Container(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: index == _focusedIndex
                  ? BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    )
                  : null,
              height: 200,
              width: 200,
              child: Image.network(
                _heroes[index].image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_heroes[_focusedIndex].biography.publisher}",
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }
}
