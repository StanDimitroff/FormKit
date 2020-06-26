import UIKit

class SectionFooterView: UITableViewHeaderFooterView {
    
    override func awakeFromNib() {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        self.backgroundView = view
    }
}
