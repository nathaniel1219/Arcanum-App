/* import 'package:arcanum/models/product.dart';

class ProductList {
  static final List<Product> tcg = [
    Product(
      name: 'Prismatic Evolution Booster Box', 
      imageUrl: 'assets/images/1_prismatic_evo.jpg',
      price: 18500.00,
      description: 'Unleash new strategies with the Prismatic Evolution Booster Box! Features rare cards, powerful new archetypes, and stunning artwork to enhance your collection.',
    ),
    Product(
      name: 'Scarlet & Violet Booster Pack', 
      imageUrl: 'assets/images/2_sv_bp.jpg',
      price: 1500.00,
      description: 'Dive into the Paldea region with a single Scarlet & Violet Booster Pack. Discover new Pokémon ex cards and exciting mechanics!',
    ),
    Product(
      name: 'Scarlet & Violet Surging Sparks Booster Pack', 
      imageUrl: 'assets/images/3_sv_surging_sparks_bp.png',
      price: 1650.00,
      description: 'Electrify your battles with the Surging Sparks Booster Pack! Features electric-type Pokémon and trainers to supercharge your deck.',
    ),
    Product(
      name: 'Scarlet & Violet Booster Box',
      imageUrl: 'assets/images/4_sf_bb.png',
      price: 21000.00,
      description: 'Get a full box of Scarlet & Violet booster packs! Perfect for serious collectors and competitive players looking for a wide variety of cards.',
    ),
    Product(
      name: 'Scarlet & Violet Temporal Forces Booster Box', 
      imageUrl: 'assets/images/5_sv_temporal_forced_bb.jpeg',
      price: 22500.00,
      description: 'Bend time and space with the Temporal Forces Booster Box. Uncover ancient and future Pokémon, and alter the flow of battle.',
    ),
    Product(
      name: 'Charizard Special Art Collection', 
      imageUrl: 'assets/images/6_charizard_art.jpeg',
      price: 12000.00,
      description: 'A must-have for Charizard fans! This collection features exclusive artwork and promotional cards of the iconic fire-type Pokémon.',
    ),
    Product(
      name: 'Pokemon Go Booster Pack',
      imageUrl: 'assets/images/7_pokemon_go_bp.jpeg',
      price: 1750.00,
      description: 'Experience the world of Pokémon GO in the TCG! Catch fan-favorite Pokémon from the popular mobile game in this special booster pack.',
    ),
    Product(
      name: 'Scarlet & Violet Stellar Crown Booster Pack', 
      imageUrl: 'assets/images/8_sv_stellar_crown_bp.png',
      price: 1900.00,
      description: 'Reach for the stars with the Stellar Crown Booster Pack. Discover cosmic Pokémon and rare trainer cards that will elevate your game.',
    ),
    Product(
      name: 'Shining Fates Greninja VMAX Box', 
      imageUrl: 'assets/images/9_sf_greninja_box.jpeg',
      price: 9500.00,
      description: 'Unleash the power of Greninja with this exclusive box. Includes special Greninja promo cards and booster packs from the set.',
    ),
    Product(
      name: 'Slifer the Sky Dragon Yu-Gi-Oh! Card', 
      imageUrl: 'assets/images/10_silfer_ygo.jpeg',
      price: 7500.00,
      description: 'Command one of the legendary Egyptian God Cards! Slifer the Sky Dragon brings immense power to any Yu-Gi-Oh! duel.',
    ),
    Product(
      name: 'Obelisk the Tormentor Yu-Gi-Oh! Card', 
      imageUrl: 'assets/images/11_obelisk_ygo.png',
      price: 7500.00,
      description: 'Dominate the field with Obelisk the Tormentor, a formidable Egyptian God Card known for its crushing attack power.',
    ),
    Product(
      name: 'Stampede Booster Box Yu-Gi-Oh!', 
      imageUrl: 'assets/images/12_stampede_bb_ygo.jpeg',
      price: 16000.00,
      description: 'Charge into battle with the Stampede Booster Box! Features new monster types and powerful spell/trap cards for dynamic duels.',
    ),
    Product(
      name: 'Stampede Booster Pack Yu-Gi-Oh!', 
      imageUrl: 'assets/images/13_stampede_bp_ygo.jpeg',
      price: 1300.00,
      description: 'Unleash new monsters and strategies with a single Stampede Booster Pack. Perfect for expanding your Yu-Gi-Oh! deck.',
    ),
    Product(
      name: 'Blue-Eyes White Dragon Yu-Gi-Oh! Card', 
      imageUrl: 'assets/images/14_blueeyes_ygo.jpeg',
      price: 6000.00,
      description: 'The legendary Blue-Eyes White Dragon! A staple for any collector or duelist, known for its iconic status and powerful attack.',
    ),
    Product(
      name: 'Alliance Booster Box Yu-Gi-Oh!', 
      imageUrl: 'assets/images/15_alliance_bb_ygo.jpeg',
      price: 17500.00,
      description: 'Forge unbreakable bonds with the Alliance Booster Box! Discover synergistic cards and build a cohesive strategy for victory.',
    ),
    Product(
      name: 'Alliance Booster Pack Yu-Gi-Oh!', 
      imageUrl: 'assets/images/16_alliance_bp_ygo.jpeg',
      price: 1450.00,
      description: 'Strengthen your deck with new allies and powerful effects from an Alliance Booster Pack.',
    ),
    Product(
      name: 'Yu-Gi-Oh! Legendary Decks II', 
      imageUrl: 'assets/images/17_lege_decks_ygo.jpeg',
      price: 11000.00,
      description: 'Relive classic duels with Legendary Decks! Features iconic cards and strategies used by fan-favorite characters from the anime.',
    ),
    Product(
      name: 'Dark Magician Girl Yu-Gi-Oh! Card', 
      imageUrl: 'assets/images/18_mag_girl_ygo.jpeg',
      price: 5500.00,
      description: 'A beloved and powerful spellcaster. Dark Magician Girl is a staple for any Yu-Gi-Oh! collection.',
    ),
  ];

  static final List<Product> collectibles = [
    Product(
      name: 'Funko Pop! LeBRON James (Lakers)',
      imageUrl: 'assets/images/19_LeBRON.png',
      price: 7500.00,
      description: 'Celebrate the basketball legend with this Funko Pop! of LeBRON James in his iconic Lakers uniform. A slam dunk for any sports collector!',
    ),
    Product(
      name: 'Funko Pop! Ice Spice',
      imageUrl: 'assets/images/20_icespice.png',
      price: 6800.00,
      description: 'Get munchy with the Funko Pop! of music sensation Ice Spice. A must-have for fans of the Bronx rapper.',
    ),
    Product(
      name: 'Funko Pop! Nezuko Kamado (Demon Slayer)',
      imageUrl: 'assets/images/21_nezuko.png',
      price: 8200.00,
      description: 'From the hit anime Demon Slayer, this Nezuko Kamado Funko Pop! captures her charm and fierce spirit. Perfect for anime enthusiasts.',
    ),
    Product(
      name: 'Funko Pop! John Wick with Dog',
      imageUrl: 'assets/images/22_johnwick.png',
      price: 9000.00,
      description: 'The Baba Yaga himself! This John Wick Funko Pop! features the legendary assassin with his loyal companion. A must-have for movie buffs.',
    ),
    Product(
      name: 'Funko Pop! Kuromi (Sanrio)',
      imageUrl: 'assets/images/23_kuromi.png',
      price: 6500.00,
      description: 'Add a touch of rebellious cuteness with the Kuromi Funko Pop! from Sanrio. A popular choice for collectors of cute and edgy characters.',
    ),
    Product(
      name: 'Funko Pop! Satoru Gojo (Jujutsu Kaisen)',
      imageUrl: 'assets/images/24_gojo.png',
      price: 10500.00,
      description: 'The strongest sorcerer! This Satoru Gojo Funko Pop! from Jujutsu Kaisen features his iconic blindfold and powerful aura. Limited stock!',
    ),
    Product(
      name: 'Funko Pop! Suguru Geto (Jujutsu Kaisen)',
      imageUrl: 'assets/images/25_geto.png',
      price: 9800.00,
      description: 'Complete your Jujutsu Kaisen collection with the charismatic Suguru Geto Funko Pop! A perfect companion to Gojo.',
    ),
    Product(
      name: 'Funko Pop! Heimerdinger (Arcane/LoL)',
      imageUrl: 'assets/images/26_heimerdinger.png',
      price: 7800.00,
      description: 'The revered Yordle scientist from League of Legends and Arcane! This Heimerdinger Funko Pop! brings his genius to your shelf.',
    ),
    Product(
      name: 'Funko Pop! Pennywise (It)',
      imageUrl: 'assets/images/27_pennywise.png',
      price: 8500.00,
      description: 'You\'ll float too! This Pennywise Funko Pop! from Stephen King\'s It is a chilling addition to any horror collection.',
    ),
  ];
} */