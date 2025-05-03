import '../models/characters.dart';
import '../web_services/api.dart';

class CharactersRepository {
  final Api api;

  CharactersRepository(this.api);

  Future<List<Character>> getAllCharacters() async {
    final characters = await api.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();

  }

  // Future<List<Quote>> getCharacterQuotes(String charName) async {
  //   final quotes = await api.getCharacterQuotes(charName);
  //   return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  // }

}


