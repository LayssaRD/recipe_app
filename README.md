# Cadastro de Receitas Culinárias

Aplicação Flutter desenvolvida para cadastro e gerenciamento de receitas culinárias.

## Funcionalidades

- Cadastro de receitas
- Edição de receitas
- Remoção com confirmação
- Busca por nome
- Filtros por:
  - categoria;
  - dificuldade;
  - vegetariana
- Validação de formulário
- Atualização dinâmica da lista
- Feedback visual com `SnackBar`

## Estrutura do Projeto

```text
lib/
├── mocks/
│   └── mock_recipes.dart
├── models/
│   └── recipe.dart
├── pages/
│   ├── receita_form_page.dart
│   └── receita_list_page.dart
├── utils/
│   └── constants.dart
└── main.dart
```

## Principais Widgets Utilizados

* `ListView.builder`
* `TextFormField`
* `DropdownButtonFormField`
* `SwitchListTile`
* `SnackBar`
* `AlertDialog`

## Telas

### Listagem

Tela responsável por exibir as receitas cadastradas, busca e filtros.

### Formulário

Tela utilizada para cadastro e edição das receitas.

## Modelo da Receita

Cada receita possui:

* nome;
* categoria;
* tempo de preparo;
* dificuldade;
* indicação se é vegetariana.

## Como Executar o Projeto

### 1. Clonar o repositório

```bash
git clone [LINK_DO_REPOSITORIO](https://github.com/LayssaRD/recipe_app.git)
```

### 2. Entrar na pasta

```bash
cd recipe_app
```

### 3. Executar a aplicação

```bash
flutter run
```
