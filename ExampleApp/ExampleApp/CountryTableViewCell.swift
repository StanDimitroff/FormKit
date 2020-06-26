import UIKit
import FormKit

class CountryTableViewCell: UITableViewCell, FormCell {
  @IBOutlet weak var countryLabel: UILabel!


  func configure(row: Row) {
    countryLabel.text = row.value
  }

  var valueChange: ((String) -> Void)?
}
