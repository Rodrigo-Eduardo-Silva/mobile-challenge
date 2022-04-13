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
    
    var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    label.text = "Carregando Repositórios.Aguarde..."
    loadRepositoriesApi()
 
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        repositories = []
        loadRepositoriesApi()
        tableView.reloadData()
        currentPage = 1
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! repositoriesTableViewController
        let repo = repositories[tableView.indexPathForSelectedRow!.row]
        vc.owner = repo
        
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
        loadingrepositories = true
        GithubAPI.loadRepositories(page: currentPage , language: selectLanguage()) { info in
            if let info = info {
                self.repositories += info.items
                self.totalrepositorires = info.total_count
                print("Total:",self.totalrepositorires,"Já Inclusos : ", self.repositories.count)
                print(self.selectLanguage())
                
                DispatchQueue.main.async {
                    self.loadingrepositories = false
                    self.tableView.reloadData()
                    
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
        tableView.backgroundView = repositories.count == 0 ? label : nil
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
