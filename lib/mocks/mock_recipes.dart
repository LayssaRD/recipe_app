import '../models/recipe.dart';

final List<Recipe> mockRecipes = [
  Recipe(
    id: '1',
    name: 'Macarrão à Carbonara',
    category: 'Prato Principal',
    preparationTimeMinutes: 20,
    difficulty: 'Médio',
    isVegetarian: false,
  ),
  Recipe(
    id: '2',
    name: 'Salada Caesar',
    category: 'Entrada',
    preparationTimeMinutes: 15,
    difficulty: 'Fácil',
    isVegetarian: true,
  ),
  Recipe(
    id: '3',
    name: 'Bolo de Chocolate',
    category: 'Sobremesa',
    preparationTimeMinutes: 45,
    difficulty: 'Médio',
    isVegetarian: true,
  ),
  Recipe(
    id: '4',
    name: 'Sushi Vegetariano',
    category: 'Prato Principal',
    preparationTimeMinutes: 60,
    difficulty: 'Difícil',
    isVegetarian: true,
  ),
  Recipe(
    id: '5',
    name: 'Sopa de Tomate',
    category: 'Entrada',
    preparationTimeMinutes: 30,
    difficulty: 'Fácil',
    isVegetarian: true,
  ),
  Recipe(
    id: '6',
    name: 'Frango Grelhado',
    category: 'Prato Principal',
    preparationTimeMinutes: 35,
    difficulty: 'Fácil',
    isVegetarian: false,
  ),
];
