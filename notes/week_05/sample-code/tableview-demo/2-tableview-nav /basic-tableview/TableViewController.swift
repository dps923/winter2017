import UIKit

/*
 This builds on the previous example.

 In Interface Builder I did the following setup:
 1) Embed the Table View Controller in a Navigation Controller (Editor->Embed In->Navigation Controller)
 2) Create a tableView outlet
 3) Add the ColorDetailViewController and add a segue
 */

class TableViewController: UITableViewController {

    var model: Model! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.colorNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
        cell.textLabel?.text = model.colorNames[indexPath.row]
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! ColorDetailViewController
        detail.model = model

        // The view of a UITableViewController is a UITableView by definition
        let tableView = view as! UITableView

        let indexPath = tableView.indexPathForSelectedRow!

        detail.colorName = model.colorNames[indexPath.row]
    }

}
