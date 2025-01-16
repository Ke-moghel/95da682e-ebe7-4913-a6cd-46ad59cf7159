import UIKit

public extension UIView {
    func pinEdges(to view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ])
    }

    static func seperatorView(insets: UIEdgeInsets? = nil) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        let seperatorView = UIView()
        seperatorView.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale).isActive = true
        seperatorView.backgroundColor = .white
        seperatorView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(seperatorView)

        if let insets = insets {
            seperatorView.pinEdges(to: containerView, insets: insets)
        } else {
            seperatorView.pinEdges(to: containerView)
        }

        return containerView
    }
}
