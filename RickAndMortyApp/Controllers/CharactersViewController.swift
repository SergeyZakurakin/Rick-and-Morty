//
//  TableViewController.swift
//  RickAndMortyApp
//
//  Created by Sergey Zakurakin on 14/05/2024.
//

import UIKit

final class CharactersViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    var rickAndMorty: RickAndMorty?
    
    private var names: [String] = []
    private var gender: [String] = []
    
    private var image: String?
    private var characterImages: [UIImage] = []
    var infoCharacter: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataAndUpdateTable()

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let CharacterInfoVC = segue.destination as? CharacterInfoViewController
        CharacterInfoVC?.character = infoCharacter[indexPath.row]
    }
    
    
    
    func fetchDataAndUpdateTable() {
        Task {
            do {
                rickAndMorty = try await networkManager.getData(from: RickAndMortyApi.baseUrl.url)
                names = rickAndMorty?.results.map { $0.name } ?? []
                gender = rickAndMorty?.results.map { $0.gender} ?? []
                infoCharacter = rickAndMorty?.results.map {$0.description} ?? []
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData() // Обновляем таблицу после получения данных
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }


    
//    func fetchImageAndUpdateCell(at indexPath: IndexPath) {
//            guard let character = rickAndMorty?.results[indexPath.row] else { return }
//            
//            Task {
//                let imageUrlString = character.image
//                guard let imageUrl = URL(string: imageUrlString) else {
//                    print("Invalid URL for image: \(imageUrlString)")
//                    return
//                }
//                
//                do {
//                    let image = try await networkManager.getImage(from: imageUrlString)
//                    
//                    DispatchQueue.main.async {
//                        // Обновление ячейки, если она все еще видима
//                        self.characterImages[indexPath.row] = image
//                        if let updatedCell = self.tableView.cellForRow(at: indexPath) {
//                            var updatedContent = updatedCell.defaultContentConfiguration()
//                            updatedContent.text = self.names[indexPath.row]
//                            updatedContent.image = image
//                            updatedCell.contentConfiguration = updatedContent
//                        }
//                    }
//                } catch {
//                    print("Не удалось загрузить изображение для персонажа: \(character.name)")
//                }
//            }
//        }
    
    
//
//    func fetchImageAndUpdateCell(at indexPath: IndexPath) {
//            guard let character = rickAndMorty?.results[indexPath.row] else { return }
//            
//            Task {
//                let imageUrlString = character.image
//                guard let imageUrl = URL(string: imageUrlString) else {
//                    print("Invalid URL for image: \(imageUrlString)")
//                    return
//                }
//                
//                do {
//                    let image = try await networkManager.getImage(from: imageUrlString)
//                    DispatchQueue.main.async {
//                        // Обновление ячейки, если она все еще видима
//                        self.characterImages[indexPath.row] = image
//                        if let updatedCell = self.tableView.cellForRow(at: indexPath) {
//                            var updatedContent = updatedCell.defaultContentConfiguration()
//                            updatedContent.text = self.names[indexPath.row]
//                            updatedContent.image = image
//                            updatedCell.contentConfiguration = updatedContent
//                        }
//                    }
//                } catch {
//                    print("Не удалось загрузить изображение для персонажа: \(character.name)")
//                }
//            }
//        }


        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return names.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            
            content.text = names[indexPath.row]
            content.secondaryText = gender[indexPath.row]
            //                    content.image = characterImages[indexPath.row]
            cell.contentConfiguration = content
            
            // Вызов функции для загрузки изображения и обновления ячейки
            
            return cell
        }
    
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        80
//    }
    
    
    
    
    
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
