import 'package:color_box_game/bloc/cubit/game_cubit.dart';
import 'package:color_box_game/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Wrap(
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                children: boxes.map((e) {
                  return BlocBuilder<GameCubit, GameState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: context.read()<GameCubit>(),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: e.color,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      );
                    },
                  );
                }).toList())
          ],
        ),
      ),
    );
  }
}
