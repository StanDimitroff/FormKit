import UIKit
import FormKit

class UserTableViewCell: UITableViewCell, FormCellProtocol {
  var value: String = "" {
    didSet {
      self.textLabel?.text = value
    }
  }

  var valueChange: ((String) -> Void)?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)

    textLabel?.numberOfLines = 0
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(row: Row) {
    self.textLabel?.text = row.value
  }
}
