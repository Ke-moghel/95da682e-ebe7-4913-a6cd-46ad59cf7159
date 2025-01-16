import UIKit

class IntroductionViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
        startButton.layer.cornerCurve = .continuous
    }
}

extension IntroductionViewController {
    @IBAction func startButtonTapped(_ sender: Any) {
        UserDefaults.didStartAssignment = true
        let controller = EngineersTableViewController(style: .grouped)

        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true)
    }
}
