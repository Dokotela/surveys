import 'package:fhir/r4.dart';

final testQuestionnaire = Questionnaire(
  name: 'fhir_questionnaire_for_testing',
  title: 'Fhir Questionnaire for Testing Purposes',
  item: [
    QuestionnaireItem(
        linkId: 'demographics',
        text: 'Demographic Section',
        type: QuestionnaireItemType.group,
        item: [
          QuestionnaireItem(
            linkId: 'demographics/integer',
            text: 'How old are you?',
            type: QuestionnaireItemType.integer,
          ),
          QuestionnaireItem(
            linkId: 'demographics/date',
            text: 'When is your birthdate?',
            type: QuestionnaireItemType.date,
          ),
          QuestionnaireItem(
            linkId: 'demographics/datetime',
            text: 'What is the date and time now?',
            type: QuestionnaireItemType.datetime,
          ),
          QuestionnaireItem(
            linkId: 'demographics/string',
            text: 'Please write out the words f*** y**',
            type: QuestionnaireItemType.string,
          ),
          QuestionnaireItem(
            linkId: 'demographics/text',
            text: 'Tell me a story',
            type: QuestionnaireItemType.text,
          ),
          QuestionnaireItem(
            linkId: 'demographics/boolean',
            text: 'I am a doodoo head',
            type: QuestionnaireItemType.boolean,
            required_: Boolean(true),
          ),
        ]),
    QuestionnaireItem(
        linkId: 'pmhx',
        text: 'Past Medical History Section',
        type: QuestionnaireItemType.group,
        item: [
          QuestionnaireItem(
            linkId: 'pmhx/decimal',
            text: 'What is your weight?',
            type: QuestionnaireItemType.decimal,
          ),
          QuestionnaireItem(
              linkId: 'pmhx/open_choice',
              text: 'Check the medical problems that you have',
              type: QuestionnaireItemType.open_choice,
              repeats: Boolean(true),
              answerOption: [
                QuestionnaireAnswerOption(valueString: 'Heart Disease'),
                QuestionnaireAnswerOption(valueString: 'Lung Disease'),
                QuestionnaireAnswerOption(valueString: 'Kidney Disease'),
              ]),
          QuestionnaireItem(
            linkId: 'pmhx/group',
            text: 'Complete each system',
            type: QuestionnaireItemType.group,
            item: [
              QuestionnaireItem(
                  linkId: 'pmhx/group/heart',
                  text: 'Cardiac Disease',
                  type: QuestionnaireItemType.group,
                  item: [
                    QuestionnaireItem(
                      linkId: 'pmhx/group/heart/dz',
                      text: 'You fucked up, I don\'t have heart disease',
                      type: QuestionnaireItemType.boolean,
                    ),
                    QuestionnaireItem(
                        linkId: 'pmhx/group/heart/specific',
                        text: 'Check the medical problems that you have',
                        type: QuestionnaireItemType.open_choice,
                        repeats: Boolean(true),
                        answerOption: [
                          QuestionnaireAnswerOption(valueString: 'MI'),
                          QuestionnaireAnswerOption(valueString: 'CHF'),
                          QuestionnaireAnswerOption(valueString: 'Broken'),
                        ]),
                  ]),
              QuestionnaireItem(
                linkId: 'pmhx/group/lung',
                text: 'Pulmonary Disease',
                type: QuestionnaireItemType.group,
                item: [
                  QuestionnaireItem(
                    linkId: 'pmhx/group/lung/dz',
                    text: 'You fucked up, I don\'t have lung disease',
                    type: QuestionnaireItemType.boolean,
                  ),
                  QuestionnaireItem(
                      linkId: 'pmhx/group/lung/specific',
                      text: 'Check the medical problems that you have',
                      type: QuestionnaireItemType.open_choice,
                      answerOption: [
                        QuestionnaireAnswerOption(valueString: 'Asthma'),
                        QuestionnaireAnswerOption(valueString: 'COPD'),
                        QuestionnaireAnswerOption(valueString: 'Coal-miners'),
                      ]),
                ],
              ),
              QuestionnaireItem(
                linkId: 'pmhx/group/kidney',
                text: 'Kidneys Disease',
                type: QuestionnaireItemType.group,
                item: [
                  QuestionnaireItem(
                    linkId: 'pmhx/group/kidney/dz',
                    text: 'You fucked up, I don\'t have kidney disease',
                    type: QuestionnaireItemType.boolean,
                  ),
                  QuestionnaireItem(
                      linkId: 'pmhx/group/kidney/specific',
                      text: 'Check the medical problems that you have',
                      type: QuestionnaireItemType.open_choice,
                      answerOption: [
                        QuestionnaireAnswerOption(valueString: 'CKD'),
                        QuestionnaireAnswerOption(valueString: 'AKI'),
                        QuestionnaireAnswerOption(valueString: 'Squishy'),
                      ]),
                ],
              ),
            ],
          ),
        ]),
    QuestionnaireItem(
      linkId: 'fhx',
      text: 'Family Medical History Section',
      type: QuestionnaireItemType.group,
    ),
    QuestionnaireItem(
        linkId: 'shx',
        text: 'Social History Section',
        type: QuestionnaireItemType.group,
        item: [
          QuestionnaireItem(
            linkId: 'shx/display',
            text: 'Now is the time for sex, drugs, and rock & roll',
            type: QuestionnaireItemType.display,
          ),
          QuestionnaireItem(
              linkId: 'shx/smoking',
              text: 'Do you smoke',
              type: QuestionnaireItemType.choice,
              answerOption: [
                QuestionnaireAnswerOption(valueString: 'Yes'),
                QuestionnaireAnswerOption(valueString: 'No'),
              ]),
          QuestionnaireItem(
              linkId: 'shx/alcohol',
              text: 'Do you drink',
              type: QuestionnaireItemType.choice,
              answerOption: [
                QuestionnaireAnswerOption(valueString: 'Yes'),
                QuestionnaireAnswerOption(valueString: 'No'),
              ]),
          QuestionnaireItem(
              linkId: 'shx/illicits',
              text: 'Do you do any other drugs',
              type: QuestionnaireItemType.choice,
              answerOption: [
                QuestionnaireAnswerOption(valueString: 'Yes'),
                QuestionnaireAnswerOption(valueString: 'No'),
                QuestionnaireAnswerOption(
                    valueString: 'I don\'t want to answer'),
              ]),
        ]),
  ],
);

// open-choice
// time
// url
// question
// attachment
// reference
// quantity