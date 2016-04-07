part of brawl;

/// Available types for [Card] objects.
enum CardType {
  SPELL,
  CREATURE,
  HERO,
  HERO_ABILITY
}

/// Cast [value] to enum of type [t].
CardType cardTypeFromString(String value) {
  return (reflectType(CardType) as ClassMirror).getField(#values).reflectee.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}