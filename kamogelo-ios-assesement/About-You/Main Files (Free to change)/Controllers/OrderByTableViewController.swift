import UIKit

class OrderByTableViewController: UITableViewController {

    var sortingHandler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) ?? UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Years"
        case 1:
            cell.textLabel?.text = "Coffees"
        case 2:
            cell.textLabel?.text = "Bugs"
        default:
            break
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var selectedAttribute: String = ""
        
        switch indexPath.row {
        case 0:
            selectedAttribute = "Years"
        case 1:
            selectedAttribute = "Coffees"
        case 2:
            selectedAttribute = "Bugs"
        default:
            break
        }

        sortingHandler?(selectedAttribute)
        dismiss(animated: true, completion: nil)
    }
}


