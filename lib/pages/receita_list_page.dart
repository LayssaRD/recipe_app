import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../mocks/mock_recipes.dart';
import '../utils/constants.dart';
import 'receita_form_page.dart';

class ReceitaListPage extends StatefulWidget {
  const ReceitaListPage({super.key});

  @override
  State<ReceitaListPage> createState() => _ReceitaListPageState();
}

class _ReceitaListPageState extends State<ReceitaListPage> {
  final List<Recipe> _recipes = List.from(mockRecipes);
  List<Recipe> _filtered = [];
  final _search = TextEditingController();
  String _category = 'Todos';
  String _difficulty = 'Todos';
  bool _vegetarianOnly = false;

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_recipes);
    _search.addListener(_apply);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _apply() {
    final q = _search.text.toLowerCase();
    setState(() {
      _filtered = _recipes.where((r) {
        final byQuery = r.name.toLowerCase().contains(q);
        final byCat = _category == 'Todos' || r.category == _category;
        final byDiff = _difficulty == 'Todos' || r.difficulty == _difficulty;
        final byVeg = !_vegetarianOnly || r.isVegetarian;
        return byQuery && byCat && byDiff && byVeg;
      }).toList();
    });
  }

  Future<void> _openForm([Recipe? toEdit]) async {
    final result = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(builder: (_) => ReceitaFormPage(recipeToEdit: toEdit)),
    );
    if (result == null) return;
    final idx = _recipes.indexWhere((r) => r.id == result.id);
    setState(() {
      if (idx >= 0) {
        _recipes[idx] = result;
      } else {
        _recipes.add(result);
      }
      _apply();
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(idx >= 0 ? 'Atualizado' : 'Adicionado')),
    );
  }

  void _remove(Recipe r) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover receita?'),
        content: Text('Remover "${r.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _recipes.removeWhere((x) => x.id == r.id);
                _apply();
              });
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Removido')));
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  void _resetFilters() {
    _search.clear();
    setState(() {
      _category = 'Todos';
      _difficulty = 'Todos';
      _vegetarianOnly = false;
      _apply();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receitas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar...',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _category,
                    items: ['Todos', ...RecipeConstants.categories]
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      _category = v ?? _category;
                      _apply();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: _difficulty,
                    items: ['Todos', ...RecipeConstants.difficulties]
                        .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                        .toList(),
                    onChanged: (v) {
                      _difficulty = v ?? _difficulty;
                      _apply();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _resetFilters,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _vegetarianOnly,
                onChanged: (v) {
                  _vegetarianOnly = v ?? false;
                  _apply();
                },
              ),
              const Text('Vegetariana'),
            ],
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('Nenhuma receita encontrada'))
                : ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final r = _filtered[i];
                      return ListTile(
                        leading: Icon(
                          r.isVegetarian ? Icons.eco : Icons.restaurant,
                        ),
                        title: Text(r.name),
                        subtitle: Text(
                          '${r.category} • ${r.preparationTimeMinutes} min • ${r.difficulty}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _openForm(r),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _remove(r),
                            ),
                          ],
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(r.name),
                            content: Text(
                              'Categoria: ${r.category}\nTempo: ${r.preparationTimeMinutes} min\nDificuldade: ${r.difficulty}\nVegetariana: ${r.isVegetarian ? 'Sim' : 'Não'}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Fechar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
