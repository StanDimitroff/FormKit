import UIKit
import FormKit

class TextFieldTVCell: UITableViewCell, FormCell {
  @IBOutlet weak var textField: UITextField!

  func configure(row: Row) {
    textField.text = row.value
  }

  var valueChange: ((String) -> Void)?

  override func awakeFromNib() {
    super.awakeFromNib()

    textField.delegate = self
  }
}

extension TextFieldTVCell: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    valueChange?(textField.text!)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()

      return true
  }
}
