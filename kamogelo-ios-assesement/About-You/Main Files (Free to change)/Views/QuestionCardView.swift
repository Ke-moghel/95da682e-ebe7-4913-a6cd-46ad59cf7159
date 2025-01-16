import UIKit

class QuestionCardView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionsStackView: UIStackView!
    private var selectedIndex: Int?
    private weak var currentSelection: SelectableAwnswerView?

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling()
    }

    static func loadView() -> QuestionCardView? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        return views?.first as? QuestionCardView
    }

    func setUp(with title: String, options: [String], selectedIndex: Int? = nil) {
        titleLabel.text = title
        self.selectedIndex = selectedIndex
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, optionText) in options.enumerated() {
            addOption(with: optionText, setSelected: index == selectedIndex)
        }
        ensureSelectionIsConsistent()
    }

    private func ensureSelectionIsConsistent() {
        guard let index = selectedIndex,
              index >= 0,
              index < optionsStackView.arrangedSubviews.count,
              let selectionView = optionsStackView.arrangedSubviews[index] as? SelectableAwnswerView else {
            return
        }
        selectionView.applySelectionStyling()
        currentSelection = selectionView
    }

    private func applyStyling() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }

    private func addOption(with text: String, setSelected: Bool) {
        guard let optionView = SelectableAwnswerView.loadView() else { return }
        optionView.setUp(with: text, delegate: self)
        optionsStackView.addArrangedSubview(optionView)

        if setSelected {
            optionView.applySelectionStyling()
            currentSelection = optionView
        }
    }
}
extension QuestionCardView: SelectionViewDelegate {
    func didSelect(selectionview: SelectableAwnswerView) {
        currentSelection?.deselect()
        currentSelection = selectionview
        selectionview.applySelectionStyling()
        selectedIndex = optionsStackView.arrangedSubviews.firstIndex(of: selectionview)
    }
}
