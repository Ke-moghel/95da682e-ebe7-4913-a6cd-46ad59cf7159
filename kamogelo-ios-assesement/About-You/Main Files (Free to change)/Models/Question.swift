import Foundation

struct Question: Codable {
    let questionText: String
    let answerOptions: [String]
    let questionType: QuestionType
    var answer: Answer?

    enum CodingKeys: String, CodingKey {
        case questionText = "question_text"
        case answerOptions = "answer_options"
        case questionType = "question_type"
        case answer
    }

    mutating func selectAnswer(at index: Int) throws {
        guard index >= 0 && index < answerOptions.count else {
            throw QuestionError.invalidAnswerIndex
        }
        self.answer = Answer(text: answerOptions[index], index: index)
    }
}

struct Answer: Codable {
    let text: String
    let index: Int
}


enum QuestionType: String, Codable {
    case slider = "SLIDER"
    case selection = "SELECTION"
}


enum QuestionError: Error, LocalizedError {
    case invalidAnswerIndex

    var errorDescription: String? {
        switch self {
        case .invalidAnswerIndex:
            return "The selected answer index is out of bounds."
        }
    }
}

class MainQuestions {
    static func createQuestion(
        text: String,
        options: [String],
        type: QuestionType = .selection,
        answer: Answer? = nil
    ) -> Question {
        return Question(questionText: text,
                        answerOptions: options,
                        questionType: type,
                        answer: answer)
    }

    static func questionOne(answer: Answer? = nil) -> Question {
        return createQuestion(
            text: "When do you have the most energy?",
            options: ["6am", "12pm", "6pm", "Midnight"],
            answer: answer
        )
    }

    static func questionTwo(answer: Answer? = nil) -> Question {
        return createQuestion(
            text: "How old were you when you wrote your first line of code?",
            options: [
                "Younger than 10 years",
                "10 to 15 years old",
                "16 to 20 years old",
                "21 to 25 years old",
                "26 years old or older"
            ],
            answer: answer
        )
    }

    static func questionThree(answer: Answer? = nil) -> Question {
        return createQuestion(
            text: "Which new programming language would you want to learn?",
            options: [
                "Python",
                "Kotlin",
                "Swift",
                "Ruby",
                "C#",
                "C++",
                "Rust",
                "None"
            ],
            answer: answer
        )
    }

    static func questionFour(answer: Answer? = nil) -> Question {
        return createQuestion(
            text: "How often do you learn a new framework or language?",
            options: [
                "Every few months",
                "Once a year",
                "Once every few years"
            ],
            answer: answer
        )
    }

    static func questionFive(answer: Answer? = nil) -> Question {
        return createQuestion(
            text: "What do you do when you get stuck on a problem?",
            options: [
                "Visit Stack Overflow",
                "Do other work and come back later",
                "Call a coworker or friend",
                "Watch or read a tutorial",
                "Go down a google rabbit hole",
                "Panic"
            ],
            answer: answer
        )
    }
}
