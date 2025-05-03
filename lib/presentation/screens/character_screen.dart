
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../businesslogic/cubit/characters_cubit.dart';
import '../../constants/mycolors.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  final Character? character;

  CharacterScreen({
    super.key,
    this.character,
  });

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character>? allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearch = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    super.initState();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: "Find a Character",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 20),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 20),
      onChanged: (searchedCharacter) {
        addSearchItemForSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchItemForSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearch) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed:_startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearch=true;
    });
  }
void _stopSearch(){
    _clearSearch();
    setState(() {
      _isSearch=false;
    });
}


void _clearSearch(){
_searchTextController.clear();
}


  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return BuildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget BuildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            BuildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget BuildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      itemCount: _searchTextController.text.isEmpty? allCharacters?.length:searchedForCharacters.length,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int i) {
        return CharacterItem(
          character:  _searchTextController.text.isEmpty?allCharacters![i]:searchedForCharacters[i],
        );
      },
    );
  }

  Widget _BuildAppBarTitle(){
    return Text(
      "characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
      leading: _isSearch? BackButton(color: MyColors.myGrey) :Container(),
      title: _isSearch ? _buildSearchField():_BuildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
