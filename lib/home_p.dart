import 'package:color_box_game/bloc/cubit/game_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int stepCounter = 0;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF2A2928),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF605E5D),
            title: const Text('Magic Cube'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xFF605E5D),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Ходов: $stepCounter',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xFF605E5D),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Совпадений: $stepCounter',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ]),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFECE8E5),
                      style: BorderStyle.solid,
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  //color: Color(0xFF605E5D),
                  child: Wrap(
                      runSpacing: 15,
                      alignment: WrapAlignment.spaceBetween,
                      children: state.boxes.map((e) {
                        return InkWell(
                          onTap: () {
                            context.read<GameCubit>().boxTap(e);
                            stepCounter++;
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: e.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      }).toList()),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF605E5D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('START'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF605E5D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('RESTART'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
