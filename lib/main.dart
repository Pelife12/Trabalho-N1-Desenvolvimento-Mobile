/*
5. App de Controle de Hábito
Objetivo: O usuário pode criar e acompanhar
o progresso de seus hábitos diários
(ex: beber água, fazer exercícios).
O app deve exibir gráficos ou listas para
visualização do progresso.
*/

import 'package:flutter/material.dart';
import 'package:myapp/mainPage.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HabitTrackerApp(),
  ));
}
