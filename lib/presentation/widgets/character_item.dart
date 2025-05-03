
import 'package:flutter/material.dart';

import '../../constants/mycolors.dart';
import '../../data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // String imageUrl = character!.image?? 'iiii'  ;
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Hero(
        tag: character.id,
        child: GridTile(
          child: Container(
            color: MyColors.myGrey,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'images/loading.gif',
                    image: character.image,
                    fit: BoxFit.cover,
                    // imageErrorBuilder: (context, error, stackTrace) {
                    //   return Center(
                    //       child: Icon(Icons.error, color: Colors.red));
                    // },
                  )
                : Image.asset('images/rehi.jpg'),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.black38,
            child: Text(
              "${character.name}",
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}
