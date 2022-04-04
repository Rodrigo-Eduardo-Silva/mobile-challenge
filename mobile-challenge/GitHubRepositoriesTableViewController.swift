//
//  GitHubRepositoriesTableViewController.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 21/03/22.
//

import UIKit

class GitHubRepositoriesTableViewController: UITableViewController {
    
    
    @IBOutlet weak var sclanguage: UISegmentedControl!
    
    
    var repositories : [GitHubInfo] = []
    var currentPage = 1
    var totalrepositorires = 0
    var loadingrepositories = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    loadRepositoriesApi()
 
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        repositories = []
        loadRepositoriesApi()
        tableView.reloadData()
        
        
    }
    
    
    func selectLanguage()-> String {
        var language = "Java"
        switch sclanguage.selectedSegmentIndex {
        case 0:
            language = "Java"
        case 1:
             language = "Swift"
        case 2:
             language = "C#"
        default:
            break
        }
        return language
    }
    
    
    func loadRepositoriesApi(){
  
        GithubAPI.loadRepositories(page: currentPage , language: selectLanguage()) { info in
            if let info = info {
                self.repositories += info.items
                self.totalrepositorires = info.total_count
                print("Total:",self.totalrepositorires,"Já Inclusos : ", self.repositories.count)
                print(self.selectLanguage())
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingrepositories = false
                }
                
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GitHubTableViewCell

        let repo = repositories[indexPath.row]
        cell.prepareCell(with: repo)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 20 && !loadingrepositories && repositories.count != totalrepositorires{
        currentPage += 1
       loadRepositoriesApi()
           
            
       }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
