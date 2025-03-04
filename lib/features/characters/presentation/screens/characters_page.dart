import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection.dart';
import '../../domain/useCase/get_characters.dart';
import '../bloc/character_bloc_cubit.dart';
import 'package:flutter/material.dart';

class CharacterListPage extends StatelessWidget {
  final CharacterCubit _characterCubit = CharacterCubit(getIt<GetCharacters>());
  final ScrollController _scrollController = ScrollController();

  CharacterListPage({Key? key}) : super(key: key) {
    _characterCubit.fetchCharacters();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _characterCubit.fetchCharacters();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty Characters')),
      body: Column(
        children: [
          // _buildSearchBar(),
          Expanded(
            child: BlocBuilder<CharacterCubit, CharacterState>(
              bloc: _characterCubit,
              builder: (context, state) {
                if (state is CharacterLoading && _characterCubit.characters.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CharacterLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.characters.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.characters.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final character = state.characters[index];
                      return ListTile(
                        leading: Image.network(character.image),
                        title: Text(character.name),
                        subtitle: Text('${character.status} - ${character.species}'),
                      );
                    },
                  );
                } else if (state is CharacterError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No Characters'));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             onChanged: (value) {
  //               _characterCubit.fetchCharacters(name: value);
  //             },
  //             decoration: InputDecoration(
  //               labelText: 'Search by name',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 8),
  //         DropdownButton<String>(
  //           hint: Text('Status'),
  //           onChanged: (value) {
  //             _characterCubit.fetchCharacters(status: value ?? '');
  //           },
  //           items: ['Alive', 'Dead', 'unknown']
  //               .map((status) => DropdownMenuItem(value: status, child: Text(status)))
  //               .toList(),
  //         ),
  //         SizedBox(width: 8),
  //         DropdownButton<String>(
  //           hint: Text('Species'),
  //           onChanged: (value) {
  //             _characterCubit.fetchCharacters(species: value ?? '');
  //           },
  //           items: ['Human', 'Alien']
  //               .map((species) => DropdownMenuItem(value: species, child: Text(species)))
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}