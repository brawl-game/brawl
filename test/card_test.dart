library brawl.test;

import 'package:brawl/brawl.dart';
import 'package:guinness/guinness.dart';

import 'dart:convert';

void main() {
  describe('Card', () {
    var cardLibrary;

    beforeEach(() {
      var resource = new Resource("package:brawl/res/basic.json");
      return resource.readAsString().then((data) {
        cardLibrary = new CardLibrary.fromJSONMap(new JsonDecoder().convert(data));
      });
    });

    describe('Libraries', () {
      it('should load the card library correctly', () {
        expect(cardLibrary.name).toEqual("Basic Library");
        expect(cardLibrary.cards.length).toEqual(4);
      });

      it('should find cards by name', () {
        var card = cardLibrary.cardByName("Snot Slug");
        expect(card).toBeNotNull();
        expect(card.name).toEqual("Snot Slug");
        expect(card.attack).toEqual(1);
        expect(card.health).toEqual(5);
      });

      it('should find cards by id', () {
        var card = cardLibrary.cardById(1);
        expect(card).toBeNotNull();
        expect(card.name).toEqual("Slimy Raider");
        expect(card.attack).toEqual(2);
        expect(card.health).toEqual(1);
      });
    });
  });
}
