// Cards provider class
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card.dart';

/// Enum to provide flag if element is a [Truth] or a [Dare].
enum CardElement { truth, dare }

/// Handles:
///
/// - Providing [Truth] and [Dare] list to the relavant listeners.
/// - Saves [Truth] and [Dare] to the relevent lists.
/// - Presents [Truth]s and [Dare]s.
/// - Finds a [Truth] or [Dare] with the highest priority.
class CardsProvider with ChangeNotifier {

  List<Truth> _truthList = [];
  List<Truth> _playerGenTruthList = [];
  List<Dare> _dareList = [];
  List<Dare> _playerGenDareList = [];

  CardElement editingMode = CardElement.truth;

  CardsProvider(Map appData) {
    _formatDataAndAssign(appData['truthList'], cardElement.truth);
    _formatDataAndAssign(appData['dareList'], cardElement.dare);
  }

  /// formats data and assigns it to correct class fields
  /// Accepts a list of [data] and a [type] to for it to be
  /// formated to.
  void _formatDataAndAssign(List data, cardElement type) {

    if (type == cardElement.truth) {
      /// Transforms [data] into a list of [Truths]
      _truthList = data.map<Truth>(
        (dataItem) {
          Truth parsedTruth = Truth(
            dataItem['ID'],
            dataItem['TEXTCONTENT'],
            dataItem['PLAYERGEN'] == 0 ? false : true,
            dataItem['PLAYERGEN'],
          );
          if (dataItem['PLAYERGEN'] == 1) {
            playerGenTruthList.add(parsedTruth);
          }
          return parsedTruth;
        },
      ).toList();

    } else {
      _dareList = data.map<Dare>(
        /// Transforms [data] into a list of [Dares]
        (dataItem) {
          Dare parsedDare = Dare(
              dataItem['ID'],
              dataItem['TEXTCONTENT'],
              dataItem['PLAYERGEN'] == 0 ? false : true,
              // 'playerGen holds a value of 0 or 1 (true), this is passed to the
              // prioirty field, assuring the user gen content is prioritised'
              dataItem['PLAYERGEN']);
          if (dataItem['PLAYERGEN'] == 1) {
            playerGenDareList.add(parsedDare);
          }
          return parsedDare;
        },
      ).toList();
    }
  }

// getters:

  List<Truth> get truthList {
    // Returns List of Cards.
    return _truthList;
  }

  List<Dare> get dareList {
    // Returns list of Dares.
    return _dareList;
  }

  List<Truth> get playerGenTruthList {
    // Returns List of Cards.
    return _playerGenTruthList;
  }

  List<Dare> get playerGenDareList {
    // Returns list of dares.
    return _playerGenDareList;
  }

  void setPlayerGenTruthList(List truthList) {
  // Sets the list of player created Truths to the param passed.
    _playerGenTruthList = truthList as List<Truth>;
  }

  void setPlayerGenDareList(List dareList) {
  // Sets the list of player created Dares to the param passed.
    _playerGenDareList = dareList as List<Dare>;
  }

  void setTruthList(List truthList) {
  // Sets the list of Truths to the param passed.
    _truthList = truthList as List<Truth>;
  }

  void setDareList(List dareList) {
  // Sets the list of Dares to the param passed.
    _dareList = dareList as List<Dare>;
  }

  /// Handles the logic of creating a [Truth] from player input.
  ///
  /// [iD] from database alongside [textContent] is 
  /// passed to [Truth] constructor.
  void addPlayerGenTruth(int iD, String textContent) async {
    Truth playerGenTruth = Truth(iD, textContent, true, 1);

    truthList.add(playerGenTruth);
    playerGenTruthList.add(playerGenTruth);

    notifyListeners();
  }

  /// Handles the logic of creating a [Dare] from player input.
  ///
  /// [iD] from database alongside [textContent] is 
  /// passed to [Dare] constructor.
  void addPlayerGenDare(int iD, String textContent) async {
    Dare playerGenDare = Dare(iD, textContent, true, 1);

    dareList.add(playerGenDare);
    playerGenDareList.add(playerGenDare);

    notifyListeners();
  }

  void removeTruth(int id) {
    // remove truth from playerGenTruth list
    setPlayerGenTruthList(_removeAndFilterHelper(playerGenTruthList, id));

    // remove truth from general truth list
    setTruthList(_removeAndFilterHelper(truthList, id));

    notifyListeners();
  }

  void removeDare(int id) {
    // remove truth from playerGenerated Dare list
    setPlayerGenDareList(_removeAndFilterHelper(playerGenDareList, id));

    // remove truth from general Dare list
    setDareList(_removeAndFilterHelper(dareList, id));

    notifyListeners();
  }

  /// Removes either a [Truth] or [Dare] from a [targetList] passed as a param
  List _removeAndFilterHelper(List targetList, id) {
    List filteredList =
        targetList.where((element) => element.id != id).toList();
    return filteredList;
  }

  /// Presents a single [Truth] based on index found by findpriorityIdx
  Truth get presentCard {
    Truth chosenTruth = truthList[_findPriorityIdx(truthList)];

    chosenTruth.lowerPriority();

    // Shuffles card list.
    truthList.shuffle();

    return chosenTruth;
  }

  /// Presents a single [Dare] based on index found by findpriorityIdx.
  Dare get presentDare {
    Dare chosenDare = dareList[_findPriorityIdx(dareList)];

    // Lowers priority of dare after it has been displayed.
    chosenDare.lowerPriority();

    // Shuffles dare list.
    dareList.shuffle();

    return chosenDare;
  }

  /// Used to find [Truth] or [Dare] of a higher priority.
  /// 
  /// Picks a random range of indexes from [targetList], returns index
  /// of ellement with highest priotity. Used to improve UX, prioritises
  /// user-gen content.
  int _findPriorityIdx(List targetList) {

    Random numberGenerator = Random();

    int startingIdx = numberGenerator.nextInt(targetList.length - 3);

    // Holds current max priority of elmenebt
    int max = 0;
    // Holds the index of element with the highest priority
    int maxIdx = startingIdx;

    // Loop used to find index of element with the highest priority.
    for (int i = startingIdx; i < startingIdx + 3; i++) {
      if (targetList[i].priority > max) {
        max = targetList[i].priority;
        maxIdx = i;
      }
    }

    return maxIdx;
  }
}
