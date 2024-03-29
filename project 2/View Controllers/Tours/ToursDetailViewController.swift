//
//  ToursDetailViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit
import AVKit

class ToursDetailViewController: UIViewController {

    var tour: Tour = Tour()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addFavorite(_ sender: UIButton) {
        let favorites = FavoritesStore()
        
        if !favorites.isFavorite(tour) {
            favorites.addFavorite(tour)
        }
    }
    
    // SOURCE: https://stackoverflow.com/questions/25932570/how-to-play-video-with-avplayerviewcontroller-avkit-in-swift?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    @IBAction func playContent(_ sender: UIButton) {
        let player = AVPlayer(url: tour.url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
}
