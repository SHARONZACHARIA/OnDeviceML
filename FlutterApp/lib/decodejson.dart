import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Class to convert string to matrix to feed into neural network
class Tokenize {
  int count;
  String path;

  // Constructor to initialize matrix size and josn file path
 Tokenize(this.count, this.path);

  // Below method convert a string into sparx matrix of a specific size
  // josn file contains words and index value of a word  (path)
  // take the first n (count) occuring words
  // if count is 100 our matrix will have 100 elements , it should be same as  the max_words value used in training the model.
  // example : Let 'like' is the most occuring word in our trainig set our json file will have 'like' with index value 1 and least occuing
  // word be 'that' with highest index number.
  // Consider a user input string like 'i like that' then corresponding matrix will be [1,0,0,1...0,0,1] , here the  fisrt
  // elemnt will be '1'  because the word 'like is in user input and 'that' is least occuirng word ,here 'i' is the fourth most occuring word.

  Future<List<int>> getTokenized(String input) async {
    Map<String, dynamic> data = await rootBundle
        .loadString(path)
        .then((value) => jsonDecode(value)); // load json data and decode value
    var each_word = input.split(" "); // take each word from user input string
    var wordtovec = [];
    List<int> bagofwords = new List(count);

    for (var e in each_word) {
      if (data[e] != null) wordtovec.add(data[e]);
    }

   print("each_word $each_word");
   print("wo2vec ${wordtovec[0]}");
    // if elements of wordtovec is in json file add a '1' at that  position else '0'
    for (var i = 0; i < count; i++) {
      if (wordtovec.contains(i))
        bagofwords[i] = 1;
      else
        bagofwords[i] = 0;
    }
    // return matrix
    return bagofwords;
  }
}
