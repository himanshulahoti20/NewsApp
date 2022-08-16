//
//  ViewController.swift
//  News
//
//  Created by Himanshu Lahoti on 05/07/22.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class NewsViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    var articleArray = [Article]()
    var newsDelegate = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "DisplayCell", bundle: nil), forCellReuseIdentifier: "DisplayCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsDelegate.delegate = self
        self.newsTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsDelegate.getNewsData{(sucessful) in
            if sucessful{
                print("Succesful")
                self.newsTableView.reloadData()
            }else {
                print("Unsuccessful")
            }
        }
    }
}

extension NewsViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  newsTableView.dequeueReusableCell(withIdentifier: "DisplayCell", for: indexPath) as! DisplayCell
        var titles = String()
        var sources = String()
        if articleArray.count > 0 {
            titles = articleArray[indexPath.row].title ?? "Unknown"
            sources = (articleArray[indexPath.row].source?.name)!
            if articleArray[indexPath.row].urlToImage != nil {
                cell.imgNewsImage.sd_addActivityIndicator()
                cell.imgNewsImage.sd_setImage(with: URL(string: articleArray[indexPath.row].urlToImage!)){image,error,urls,_ in
                    cell.imgNewsImage.sd_removeActivityIndicator()
                    if error != nil{
                        cell.imgNewsImage.image = UIImage(named : "errorImage")
                    } else {
                        cell.imgNewsImage.image =  image
                    }
                }
            } else {
                cell.imgNewsImage.image = UIImage(named: "errorImage")
            }
        } else {
            titles = " "
            sources = " "
        }
        cell.imgNewsImage.layer.cornerRadius = 15
        cell.configureCell(newsTitle: titles, newsSource: sources)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urls = articleArray[indexPath.row].url
        let story : UIStoryboard = UIStoryboard(name: "Main",bundle : nil)
        let newVC =  story.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        newVC.UrlString = urls
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}
extension NewsViewController: FetchDataDelegate{
    func reloadData(newsArray: [NewsModel]) {
        articleArray = newsArray[0].articles!
        newsTableView.reloadData()
    }
}
