//
//  DetailCollection.swift
//  thumbnailUrl
//
//  Created by chia on 2020/12/18.
//

import UIKit

class DetailCollection: UIViewController {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var GrandId: UILabel!
    @IBOutlet weak var GrandTitle: UILabel!
    var color: Color?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let color = color {
            self.GrandId.text = "My ID is:\(color.id)"
            self.GrandTitle.text = "My maxim: \(color.title)"
            let task = URLSession.shared.dataTask(with: color.thumbnailUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.thumbImage.image = UIImage(data: data)
                    }
                }else {
                    print("data not found")
                }
            }
            task.resume()
        }else {
            print("color not found")
        }
    }
}
