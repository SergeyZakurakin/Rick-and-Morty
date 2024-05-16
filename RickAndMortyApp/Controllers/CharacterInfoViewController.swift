//
//  CharacterInfoViewController.swift
//  RickAndMortyApp
//
//  Created by Sergey Zakurakin on 16/05/2024.
//

import UIKit

class CharacterInfoViewController: UIViewController {

    
    
    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var characterDescription: UILabel!
    
    var character: String!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterDescription.text = character
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
