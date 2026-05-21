import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/constants.dart';

class ReceitaFormPage extends StatefulWidget {
  final Recipe? recipeToEdit;

  const ReceitaFormPage({super.key, this.recipeToEdit});

  @override
  State<ReceitaFormPage> createState() => _ReceitaFormPageState();
}

class _ReceitaFormPageState extends State<ReceitaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  String _category = RecipeConstants.categories.first;
  String _difficulty = RecipeConstants.difficulties.first;
  bool _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    final r = widget.recipeToEdit;
    if (r != null) {
      _nameController.text = r.name;
      _timeController.text = r.preparationTimeMinutes.toString();
      _category = r.category;
      _difficulty = r.difficulty;
      _isVegetarian = r.isVegetarian;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final recipe = Recipe(
      id: widget.recipeToEdit?.id ?? DateTime.now().toIso8601String(),
      name: _nameController.text.trim(),
      category: _category,
      preparationTimeMinutes: int.parse(_timeController.text.trim()),
      difficulty: _difficulty,
      isVegetarian: _isVegetarian,
    );
    Navigator.pop(context, recipe);
  }

  void _clear() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _timeController.clear();
    setState(() {
      _category = RecipeConstants.categories.first;
      _difficulty = RecipeConstants.difficulties.first;
      _isVegetarian = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.recipeToEdit != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Editar Receita' : 'Nova Receita')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nome obrigatório';
                  if (v.trim().length < 3) return 'Mínimo 3 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _category,
                items: RecipeConstants.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? _category),
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Categoria obrigatória';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Tempo (min)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Tempo obrigatório';
                  final n = int.tryParse(v.trim());
                  if (n == null || n <= 0) return 'Digite minutos válidos';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _difficulty,
                items: RecipeConstants.difficulties
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _difficulty = v ?? _difficulty),
                decoration: const InputDecoration(labelText: 'Dificuldade'),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Selecione uma dificuldade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Vegetariana'),
                value: _isVegetarian,
                onChanged: (v) => setState(() => _isVegetarian = v),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: Text(editing ? 'Atualizar' : 'Salvar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
