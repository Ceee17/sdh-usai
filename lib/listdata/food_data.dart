import 'package:uas/models/CartFood.dart';
import 'package:uas/models/Food.dart';

// FILTERED
List<Food> filterFoodByZone(String zone) {
  return Foods.where((food) => food.zone == zone).toList();
}

// FOOD ITEMS
final List<Food> Foods = [
  // FAUNA
  Food(
    image: 'assets/food/junglejambalaya.jpg',
    title: 'Jungle Jambalaya',
    price: 75000,
    description:
        'A hearty dish of rice, chicken, sausage, and shrimp, spiced with a blend of Creole seasonings.',
    zone: 'fauna',
    category: 'food',
  ),
  Food(
    image: 'assets/food/wildlifewrap.jpg',
    title: 'Wildlife Wrap',
    price: 45000,
    description:
        'A whole wheat wrap filled with grilled chicken, avocado, lettuce, and a creamy herb dressing.',
    zone: 'fauna',
    category: 'food',
  ),
  Food(
    image: 'assets/food/savannahsalad.jpg',
    title: 'Savannah Salad',
    price: 50000,
    description:
        'A mix of fresh greens, cherry tomatoes, cucumbers, and feta cheese, served with a light vinaigrette.',
    zone: 'fauna',
    category: 'food',
  ),
  Food(
    image: 'assets/food/safarismoothies.jpg',
    title: 'Safari Smoothies',
    price: 35000,
    description:
        'A refreshing blend of mango, pineapple, banana, and coconut milk.',
    zone: 'fauna',
    category: 'food',
  ),
  // SEA
  Food(
    image: 'assets/food/oceanbreezesalad.jpg',
    title: 'Ocean Breeze Salad',
    price: 50000,
    description:
        'Mixed greens topped with seared tuna, avocado, cucumber, and sesame dressing.',
    zone: 'sea',
    category: 'food',
  ),
  Food(
    image: 'assets/food/seafoodpaella.jpg',
    title: 'Seafood Paella',
    price: 72000,
    description:
        'A traditional Spanish dish with saffron-infused rice, mussels, shrimp, calamari, and chorizo.',
    zone: 'sea',
    category: 'food',
  ),
  Food(
    image: 'assets/food/salmonsandwich.jpg',
    title: 'Salmon Sandwich',
    price: 85000,
    description:
        'Grilled salmon filet with arugula, red onion, and a dill yogurt sauce on a toasted bun.',
    zone: 'sea',
    category: 'food',
  ),
  Food(
    image: 'assets/food/tropicalfruitbowl.jpg',
    title: 'Tropical Fruit Bowl',
    price: 45000,
    description:
        'A mix of fresh tropical fruits like pineapple, mango, and kiwi, served with a drizzle of honey.',
    zone: 'sea',
    category: 'food',
  ),

  // BIRD
  Food(
    image: 'assets/food/avocadotoast.jpg',
    title: 'Avian Avocado Toast',
    price: 45000,
    description:
        'Toasted sourdough bread topped with smashed avocado, cherry tomatoes, and poached eggs.',
    zone: 'bird',
    category: 'food',
  ),
  Food(
    image: 'assets/food/featheredtacos.jpg',
    title: 'Feathered Tacos',
    price: 30000,
    description:
        'Soft corn tortillas filled with grilled chicken, pico de gallo, lettuce, and avocado cream.',
    zone: 'bird',
    category: 'food',
  ),
  Food(
    image: 'assets/food/birdnestpasta.jpeg',
    title: "Bird's Nest Pasta",
    price: 75000,
    description:
        'Spaghetti with a light pesto sauce, cherry tomatoes, and grilled chicken.',
    zone: 'bird',
    category: 'food',
  ),
  Food(
    image: 'assets/food/parrotparfait.jpg',
    title: 'Parrot Parfait',
    price: 45000,
    description:
        'Layers of Greek yogurt, granola, and mixed berries, topped with a drizzle of honey.',
    zone: 'bird',
    category: 'food',
  ),

  // FOREST
  Food(
    image: 'assets/food/witchbrewsoup.jpg',
    title: "Witch's Brew Soup",
    price: 45000,
    description:
        'A hearty pumpkin and butternut squash soup, served with a side of crusty bread.',
    zone: 'forest',
    category: 'food',
  ),
  Food(
    image: 'assets/food/ghostlyshrimp.jpg',
    title: 'Ghostly Shrimp',
    price: 60000,
    description:
        'Sautéed shrimp in a garlic and butter sauce, served over a bed of wild rice.',
    zone: 'forest',
    category: 'food',
  ),
  Food(
    image: 'assets/food/mysticalmushroomrisotto.jpg',
    title: 'Mystical Mushroom Risotto',
    price: 55000,
    description: 'Creamy risotto with a mix of wild mushrooms and truffle oil.',
    zone: 'forest',
    category: 'food',
  ),
  Food(
    image: 'assets/food/hauntedhousebrownies.jpg',
    title: 'Haunted House Brownies',
    price: 35000,
    description:
        'Rich chocolate brownies with a spooky twist, topped with ghost-shaped marshmallows.',
    zone: 'forest',
    category: 'food',
  ),
];

List<CartFood> tempFoodCart = [];
