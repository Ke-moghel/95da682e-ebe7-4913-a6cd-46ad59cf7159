import UIKit
import SwiftUI

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var questions: [Question] = []
        var engineer: Engineer!
        var tableView: UITableView!

        static func loadController(with questions: [Question], for engineer: Engineer) -> QuestionsViewController {
            let viewController = QuestionsViewController(nibName: String(describing: self), bundle: Bundle(for: self))
            viewController.loadViewIfNeeded()
            viewController.setUp(with: questions, for: engineer)
            return viewController
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "About"
            scrollView.delegate = self
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setupNavigationBar()
        }

        private func setupNavigationBar() {
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }

        func setUp(with questions: [Question], for engineer: Engineer) {
            loadViewIfNeeded()
            self.engineer = engineer
            addProfileView(for: engineer)
            questions.forEach { addQuestion(with: $0) }
            self.questions = questions
        }


        private func addProfileView(for engineer: Engineer) {
            let quote = engineer.questions.first { question in
                    question.questionText == "What do you do when you get stuck on a problem?"
                }?.answer?.text ?? "No answer provided"
            
            let profileView = ProfileView(
                profileImage: engineer.profileImage ?? UIImage(),
                name: engineer.name,
                title: engineer.role,
                years: engineer.years,
                coffees: engineer.coffees,
                bugs: engineer.bugs,
                quote: quote
            )

            let hostingController = UIHostingController(rootView: profileView)
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            containerStack.addArrangedSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }

        private func addQuestion(with data: Question) {
            guard let cardView = QuestionCardView.loadView() else { return }
            cardView.setUp(with: data.questionText,
                           options: data.answerOptions,
                           selectedIndex: data.answer?.index)
            containerStack.addArrangedSubview(cardView)
        }

        func updateTableViewCellWithImage(_ newImage: UIImage) {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let cell = tableView.cellForRow(at: indexPath) as? GlucodianTableViewCell {
                    cell.setUp(with: engineer.name, role: engineer.role, image: newImage)
                }
            }
        }
    }


