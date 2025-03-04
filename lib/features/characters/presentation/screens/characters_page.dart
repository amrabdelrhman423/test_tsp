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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty Characters')),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        bloc: _characterCubit,
        builder: (context, state) {
          if (state is CharacterLoading && _characterCubit.characters.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.characters.length + 1,
              itemBuilder: (context, index) {
                if (index == state.characters.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name),
                  subtitle: Text(character.status),
                );
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No data'));
        },
      ),
    );
  }
}