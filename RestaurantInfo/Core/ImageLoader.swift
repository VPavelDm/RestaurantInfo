//
//  ImageLoader.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 22/09/2021.
//

import UIKit

class ImageLoader {
    func load(url: URL, completion: @escaping (UIImage) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                completion(image!)
            }
        }
    }
}
