library brawl.example;

import 'package:brawl/brawl.dart';
import 'dart:convert';

void main() async {
  // Set up a new game
  final game = new Game();

  // Load card library
  Resource libraryResource = new Resource("package:brawl/res/basic.json");
  String libraryJSON;
  await libraryResource.readAsString().then((data) {
    libraryJSON = data;
  });
  final cardLibrary = new CardLibrary.fromJSONMap(new JsonDecoder().convert(libraryJSON));

  // Create decks
  var deckOne = new CardDeck("Test 1", cardLibrary.randomCardOfType(CardType.HERO).id, cardLibrary, []);
  var deckTwo = new CardDeck("Test 2", cardLibrary.randomCardOfType(CardType.HERO).id, cardLibrary, []);

  // Fill decks with cards
  [deckOne, deckTwo].forEach((deck) {
    while (deck.cards.length < 30) {
      deck.cards.add(cardLibrary.randomCardOfType(CardType.CREATURE));
    }
  });

  // Create some players
  final mauno = new Player("Mauno", deckOne);
  final jonne = new Player("Jonne", deckTwo);
  mauno.joinGame(game);
  jonne.joinGame(game);

  // Prepare the game
  game.initialize();
  game.start();
  mauno.playCardAtIndex(0);
  mauno.playCardAtIndex(0);
  mauno.playCardAtIndex(0);
}