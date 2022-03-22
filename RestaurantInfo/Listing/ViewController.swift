//
//  ViewController.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 23/08/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var restaurants: [RestaurantInfo] = [
        RestaurantInfo(
            image: URL(string: "https://www.trapeza.by/upload/s4y_news/10634/s4y_news_photos/442/image/img_14325335424.jpeg")!,
            name: "Peaky blinders",
            adress: "Гурского 56")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        cell.setUp(info: restaurants[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! DetailsViewController
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        detailsViewController.restaurant = restaurants[indexPath!.row]
        
    }



}


