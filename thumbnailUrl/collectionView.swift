//
//  collectionView.swift
//  thumbnailUrl
//
//  Created by chia on 2020/12/17.
//

import UIKit

class collectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var jsonObj: [[String: AnyObject]]!
    @IBOutlet var collectionView: UICollectionView!
    var colorstring = "https://jsonplaceholder.typicode.com/photos"
    var colors = [Color]()
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 95, height: 95)
        collectionView.collectionViewLayout = layout
        //layout.estimatedItemSize = .zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        

        
        if let url = URL(string: colorstring) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let colorResult = try? decoder.decode([Color].self, from: data) {
                        
                        self.colors = colorResult
                        self.results = self.colors
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    

     var results = [Color]()
    
    //顯示項目內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let color = results[indexPath.row]
        cell.colorid.text = "\(color.id)"
        cell.colortitle.text = "\(color.title)"
        
        let task = URLSession.shared.dataTask(with: color.thumbnailUrl) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    return  cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = collectionView.indexPathsForSelectedItems?.first
        let row = indexPath?.item //.seciton  、 .item(row)
        let controller = segue.destination as! DetailCollection
        controller.color = results[row!]
    }
    

/*extension collectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tapped")
    }
}
extension collectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: UIImage(named: "Image")!)
        return cell
    }
}
extension collectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }*/
}
