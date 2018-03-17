//
//  FeedTableDataSource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class FeedTableDataSource: NSObject, UITableViewDataSource {

    private weak var viewModel: FeedViewModel?

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.displays.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell,
            let viewModel = viewModel
            else {
                fatalError("Dequeued wrong type of cell in FeedTableDataSource")
        }

        if viewModel.displays.count > indexPath.row {
            cell.layout(with: viewModel.displays[indexPath.row])
        }

        return cell
    }

}
