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
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0x95682808),
              title: const Text(
                'MAGIC CUBE',
                style: TextStyle(
                  color: Color(0xFF0B3353),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                      children: state.findColors
                          .map(
                            (e) => Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: e,
                              ),
                            ),
                          )
                          .toList()),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0x95682808),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Ходов: $stepCounter',
                                style: const TextStyle(
                                  color: Color(0xFF0B3353),
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
                                color: Color(0xC7332D29),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Совпадений: ${state.selectedBoxes.length ~/ 2}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 161, 166, 170),
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
                      color: Color(0xC7332D29),
                      border: Border.all(
                        color: Color(0xC7322808),
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
