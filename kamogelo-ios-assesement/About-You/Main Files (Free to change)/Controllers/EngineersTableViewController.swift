import UIKit

class EngineersTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var engineers: [Engineer] = Engineer.testingData()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engineers at Glucode"
        tableView.backgroundColor = .white
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order by",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(orderByTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func orderByTapped() {
        guard let from = navigationItem.rightBarButtonItem else { return }
        let controller = OrderByTableViewController(style: .plain)

        // Pass a closure to handle selection
        controller.sortingHandler = { [weak self] attribute in
            self?.sortEngineers(by: attribute)
        }

        let size = CGSize(width: 200, height: 150)
        present(popover: controller, from: from, size: size, arrowDirection: .up)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: GlucodianTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GlucodianTableViewCell.self))
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return engineers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GlucodianTableViewCell.self)) as? GlucodianTableViewCell
        let engineer = engineers[indexPath.row]
        cell?.setUp(with: engineer.name, role: engineer.role, image:engineer.profileImage ?? UIImage(named: "person.fill"))
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEngineer = engineers[indexPath.row]
        let controller = QuestionsViewController.loadController(with: selectedEngineer.questions, for: selectedEngineer)
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Sorting function
    func sortEngineers(by attribute: String) {
        switch attribute {
        case "Years":
            engineers.sort { $0.years > $1.years }
        case "Coffees":
            engineers.sort { $0.coffees > $1.coffees }
        case "Bugs":
            engineers.sort { $0.bugs > $1.bugs }
        default:
            break
        }
        tableView.reloadData()
    }
}
