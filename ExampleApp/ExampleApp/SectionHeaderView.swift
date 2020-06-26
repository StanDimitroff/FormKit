import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

  var insertSections: (()-> Void)?
  var removeSection: (()-> Void)?
  var addRows: (()-> Void)?

  @IBAction func removeSection(_ sender: UIButton) {
    self.removeSection?()
  }

  @IBAction func insertSections(_ sender: UIButton) {
    self.insertSections?()
  }

  @IBAction func addRows(_ sender: UIButton) {
    self.addRows?()
  }
}
