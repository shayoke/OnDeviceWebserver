//
//  PostViewController.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 16/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

final class PostViewController: UITableViewController {

    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self


        //        NetworkManager.shared.mockNetworkOn = true

        //        WebServer.stub("posts",
        //                       with: "[{\"body\":\"body\",\"id\":1,\"title\":\"title\",\"userId\":1}]")

        //        NetworkManager.shared.fetchPosts { result in
        //            dump(result)
        //        }


        NetworkManager.shared.fetchPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts

            case .failure(let error):
                dump(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension PostViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)

        if let postCell = cell as? PostCell {
            let post = posts[indexPath.row]
            postCell.titleLabel.text = post.title
            postCell.bodyLabel.text = post.body
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

final class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
}
