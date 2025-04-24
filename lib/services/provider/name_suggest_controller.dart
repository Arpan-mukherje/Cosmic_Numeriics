// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';

// class NameGeneratorController extends ChangeNotifier {
//   final Dio _dio = Dio();

//   bool isLoading = false;
//   List<String> _generatedNames = [];
//   List<String> get generatedNames => _generatedNames;
//   bool _hasGeneratedNames = false;

//   bool get hasGeneratedNames => _hasGeneratedNames;

//   Future<void> generateNames(String dob, String gender,
//       {bool append = false, String? firstLetter}) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final numerologyNumber = calculateNumerologyNumber(dob);
//       if (numerologyNumber == null) {
//         throw Exception("Invalid date of birth format");
//       }
//       final names =
//           await fetchNames(gender, numerologyNumber, firstLetter: firstLetter);
//       log(names.toString());
//       if (append) {
//         // Add new names while avoiding duplicates
//         _generatedNames = List.from(_generatedNames)
//           ..addAll(names.where((name) => !_generatedNames.contains(name)));
//       } else {
//         _generatedNames = names;
//       }
//       _hasGeneratedNames = true;
//       notifyListeners();
//     } catch (e) {
//       log("Error: $e");
//       if (!append) {
//         _generatedNames = ["Error: Could not generate names."];
//       }
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   int? calculateNumerologyNumber(String dob) {
//     try {
//       int sum = dob
//           .replaceAll("-", "")
//           .split("")
//           .where((char) => char != "")
//           .map(int.parse)
//           .reduce((a, b) => a + b);
//       return sum % 9 == 0 ? 9 : sum % 9;
//     } catch (e) {
//       log("Error in calculateNumerologyNumber: $e");
//       return null;
//     }
//   }

//   Future<List<String>> fetchNames(String gender, int numerologyNumber,
//       {String? firstLetter}) async {
//     const apiKey = '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';
//     const apiUrl = "https://api.groq.com/openai/v1/chat/completions";

//     final numerologyFamilies = {
//       1: [1, 5, 7],
//       2: [2, 4, 8],
//       3: [3, 6, 9],
//       4: [2, 4, 8],
//       5: [1, 5, 7],
//       6: [3, 6, 9],
//       7: [1, 5, 7],
//       8: [2, 4, 8],
//       9: [3, 6, 9]
//     };

//     final familyGroup =
//         numerologyFamilies[numerologyNumber] ?? [numerologyNumber];
//     log("Family Group: ${familyGroup.join(", ")}");
//     const letterValues = {
//       'a': 1,
//       'b': 2,
//       'c': 3,
//       'd': 4,
//       'e': 5,
//       'f': 8,
//       'g': 3,
//       'h': 5,
//       'i': 1,
//       'j': 1,
//       'k': 2,
//       'l': 3,
//       'm': 4,
//       'n': 5,
//       'o': 7,
//       'p': 8,
//       'q': 1,
//       'r': 2,
//       's': 3,
//       't': 4,
//       'u': 6,
//       'v': 6,
//       'w': 6,
//       'x': 5,
//       'y': 1,
//       'z': 7,
//     };

//     String prompt =
//         "Generate a list of 20 unique Indian ${gender.toLowerCase()} first names that are numerologically balanced with the numbers ${familyGroup.join(", ")}. Use the following letter values for the numerology calculation: ${letterValues.entries.map((e) => '${e.key}=${e.value}').join(", ")}.";
//     if (firstLetter != null && firstLetter.isNotEmpty) {
//       prompt += " All names should start with the letter $firstLetter.";
//     }

//     prompt +=
//         " Provide only the names in a numbered list format without any additional text or explanations. Ensure all names are unique and valid for the specified numerology criteria.";

//     try {
//       final response = await _dio.post(
//         apiUrl,
//         options: Options(headers: {
//           'Authorization': 'Bearer $apiKey',
//           'Content-Type': 'application/json',
//         }),
//         data: {
//           "model": "llama3-8b-8192",
//           "messages": [
//             {"role": "system", "content": prompt}
//           ],
//           "temperature": 0.7
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final namesText =
//             response.data['choices'][0]["message"]["content"] as String;
//         final names = namesText
//             .split('\n')
//             .where((line) =>
//                 line.isNotEmpty && RegExp(r'^\d+\.\s+').hasMatch(line))
//             .map((line) => line.replaceFirst(RegExp(r'^\d+\.\s+'), '').trim())
//             .toSet()
//             .toList();

//         final filteredNames = names.where((name) {
//           int nameNumerologyValue = name
//               .toLowerCase()
//               .split('')
//               .map((char) => letterValues[char] ?? 0)
//               .reduce((a, b) => a + b);
//           int nameNumerologyNumber =
//               nameNumerologyValue % 9 == 0 ? 9 : nameNumerologyValue % 9;
//           return familyGroup.contains(nameNumerologyNumber);
//         }).toList();

//         return filteredNames;
//       } else {
//         log("Error: Received non-200 status code: ${response.statusCode}");
//         log("Response data: ${response.data}");
//         return ["Error: Could not fetch names."];
//       }
//     } catch (e) {
//       log("Error: $e");
//       return ["Error: Could not fetch names."];
//     }
//   }

//   String _gender = "";
//   String _fLetter = "";
//   String get gender => _gender;
//   String get fLetter => _fLetter;
//   void setGender(String val) {
//     _gender = val;
//     notifyListeners();
//   }

//   void setFirstLetter(String val) {
//     _fLetter = val;
//     notifyListeners();
//   }

//   void resetValues() {
//     _gender = "";
//     _fLetter = "";
//     _generatedNames = [];
//     _hasGeneratedNames = false;
//     isLoading = false;
//     notifyListeners();
//   }
// }
//AIzaSyDkYzN-ccC0Vwp_AggL1HjFHxDU-SpKn1A
//gemini-1.5-flash
//-------------------------------------------------------------------------------------------------------------------s
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class NameGeneratorController extends ChangeNotifier {
  bool isLoading = false;
  List<String> _generatedNames = [];
  List<String> get generatedNames => _generatedNames;
  bool _hasGeneratedNames = false;

  bool get hasGeneratedNames => _hasGeneratedNames;

  Future<void> generateNames(String dob, String gender,
      {bool append = false, String? firstLetter}) async {
    isLoading = true;
    notifyListeners();

    try {
      final numerologyNumber = calculateNumerologyNumber(dob);
      if (numerologyNumber == null) {
        throw Exception("Invalid date of birth format");
      }
      final names =
          await fetchNames(gender, numerologyNumber, firstLetter: firstLetter);
      log(names.toString());
      if (append) {
        _generatedNames = List.from(_generatedNames)
          ..addAll(names.where((name) => !_generatedNames.contains(name)));
      } else {
        _generatedNames = names;
      }
      _hasGeneratedNames = true;
      notifyListeners();
    } catch (e) {
      log("Error: $e");
      if (!append) {
        _generatedNames = ["Error: Could not generate names."];
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int? calculateNumerologyNumber(String dob) {
    try {
      int sum = dob
          .replaceAll("-", "")
          .split("")
          .where((char) => char != "")
          .map(int.parse)
          .reduce((a, b) => a + b);
      return sum % 9 == 0 ? 9 : sum % 9;
    } catch (e) {
      log("Error in calculateNumerologyNumber: $e");
      return null;
    }
  }

  Future<List<String>> fetchNames(String gender, int numerologyNumber,
      {String? firstLetter}) async {
    const apiKey = 'AIzaSyCOo3NW_nI-kx3kAexPVTo62sGWl5HJeG0';

    final numerologyFamilies = {
      1: [1, 5, 7],
      2: [2, 4, 8],
      3: [3, 6, 9],
      4: [2, 4, 8],
      5: [1, 5, 7],
      6: [3, 6, 9],
      7: [1, 5, 7],
      8: [2, 4, 8],
      9: [3, 6, 9]
    };

    final familyGroup =
        numerologyFamilies[numerologyNumber] ?? [numerologyNumber];
    log("Family Group: ${familyGroup.join(", ")}");
    const letterValues = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 4,
      'e': 5,
      'f': 8,
      'g': 3,
      'h': 5,
      'i': 1,
      'j': 1,
      'k': 2,
      'l': 3,
      'm': 4,
      'n': 5,
      'o': 7,
      'p': 8,
      'q': 1,
      'r': 2,
      's': 3,
      't': 4,
      'u': 6,
      'v': 6,
      'w': 6,
      'x': 5,
      'y': 1,
      'z': 7,
    };

    String prompt =
        "Generate a list of 20 unique Indian ${gender.toLowerCase()} first names that are numerologically balanced with the numbers ${familyGroup.join(", ")}. Use the following letter values for the numerology calculation: ${letterValues.entries.map((e) => '${e.key}=${e.value}').join(", ")}.";
    if (firstLetter != null && firstLetter.isNotEmpty) {
      prompt += " All names should start with the letter $firstLetter.";
    }

    prompt +=
        " Provide only the names in a numbered list format without any additional text or explanations. Ensure all names are unique and valid for the specified numerology criteria.";

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      final namesText = response.text;
      final names = namesText
          ?.split('\n')
          .where(
              (line) => line.isNotEmpty && RegExp(r'^\d+\.\s+').hasMatch(line))
          .map((line) => line.replaceFirst(RegExp(r'^\d+\.\s+'), '').trim())
          .toSet()
          .toList();

      final filteredNames = names!.where((name) {
        int nameNumerologyValue = name
            .toLowerCase()
            .split('')
            .map((char) => letterValues[char] ?? 0)
            .reduce((a, b) => a + b);
        int nameNumerologyNumber =
            nameNumerologyValue % 9 == 0 ? 9 : nameNumerologyValue % 9;
        return familyGroup.contains(nameNumerologyNumber);
      }).toList();

      return filteredNames;
    } catch (e) {
      log("Error: $e");
      return ["Error: Could not fetch names."];
    }
  }

  String _gender = "";
  String _fLetter = "";
  String get gender => _gender;
  String get fLetter => _fLetter;
  void setGender(String val) {
    _gender = val;
    notifyListeners();
  }

  void setFirstLetter(String val) {
    _fLetter = val;
    notifyListeners();
  }

  void resetValues() {
    _gender = "";
    _fLetter = "";
    _generatedNames = [];
    _hasGeneratedNames = false;
    isLoading = false;
    notifyListeners();
  }
}
