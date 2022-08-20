import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

class CreateShipmentScreen extends StatelessWidget {
  const CreateShipmentScreen({Key? key}) : super(key: key);
// {"manufacturer" : "aaa", "startLocation" : "ABC Speaker Maker, Bangalore", "pid" : "zxcv", "totalWeight" : 50.4, "currentLat" : 128.35, "currentLong" : 74.45}
// {"shipmentID" : "62fbba53bad3f183e0f6fb00", "location" :"DESTINATION WAREHOUSE", "currentLat" : 192.35, "currentLong" : 80.45, "transportMode" : "-", "enroute_to" : "DESTINATION", "status" : "OUT FOR DELIVERY/DELIVERED"}
  @override
  Widget build(BuildContext context) {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Start shipment form',
          text: '',
          buttonText: 'Start',
        ),
        QuestionStep(
          title: 'Enter manufacturer id',
          text: 'Manufacturer id',
          answerFormat: const TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Enter product id that will be shipped',
          text: 'product id',
          answerFormat: const TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Enter Start location',
          text: 'start location',
          answerFormat: const TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Enter End location',
          text: 'End location',
          answerFormat: const TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Enter Latitude and longitude',
          text: 'product id',
          answerFormat: const TextAnswerFormat(
            maxLines: 1,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Enter the rounded Weight of the package',
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter the weight',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'Mode of transport',
          text: 'Enter the mode of transport',
          isOptional: false,
          answerFormat: const MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Air', value: 'AIR'),
              TextChoice(text: 'Water', value: 'WATER'),
              TextChoice(text: 'Rail', value: 'RAIL'),
              TextChoice(text: 'Road', value: 'ROAD'),
            ],
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[7].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return SurveyKit(
      task: task,
      themeData: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        ).copyWith(
          onPrimary: Colors.white,
        ),
        primaryColor: Colors.cyan,
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.cyan,
          ),
          titleTextStyle: TextStyle(
            color: Colors.cyan,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.cyan,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.cyan,
          selectionColor: Colors.cyan,
          selectionHandleColor: Colors.cyan,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.cyan,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(150.0, 60.0),
            ),
            side: MaterialStateProperty.resolveWith(
              (Set<MaterialState> state) {
                if (state.contains(MaterialState.disabled)) {
                  return const BorderSide(
                    color: Colors.grey,
                  );
                }
                return const BorderSide(
                  color: Colors.cyan,
                );
              },
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            textStyle: MaterialStateProperty.resolveWith(
              (Set<MaterialState> state) {
                if (state.contains(MaterialState.disabled)) {
                  return Theme.of(context).textTheme.button?.copyWith(
                        color: Colors.grey,
                      );
                }
                return Theme.of(context).textTheme.button?.copyWith(
                      color: Colors.cyan,
                    );
              },
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.cyan,
                  ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline2: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      surveyProgressbarConfiguration: SurveyProgressConfiguration(
        backgroundColor: Colors.white,
      ),
      onResult: (SurveyResult result) {
        //Read finish reason from result (result.finishReason)
        //and evaluate the results
        print(result.results.map((StepResult e) {}).toList());
      },
    );
  }
}
