//
//  ViewController.swift
//  FNMatchPull
//
//  Created by Fnoz on 16/6/24.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import UIKit
import EasyPull

let SCREENWIDTH = UIScreen.mainScreen().bounds.width
let SCREENHEIGHT = UIScreen.mainScreen().bounds.height

class ViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height - 64), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.backgroundColor =  UIColor.init(red: 45/255.0, green: 45/255.0, blue: 45/255.0, alpha: 1)
        tableView.dataSource = self
        tableView.separatorStyle = .SingleLineEtched
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        
        func delayStopDrop() {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.tableView.easy_stopDropPull()
            })
        }
        
        let matchAnimator = FNMatchPullAnimator(frame: CGRectMake(0, 0, 320, 80))
        tableView.addPullToRefreshWithAction({
            NSOperationQueue().addOperationWithBlock {
                sleep(2)
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.tableView.stopPullToRefresh()
                }
            }
            }, withAnimator: matchAnimator)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: FNMatchPullTableViewCell? = tableView.dequeueReusableCellWithIdentifier("FNMatchPullTableViewCell") as? FNMatchPullTableViewCell
        if (cell == nil) {
            cell = FNMatchPullTableViewCell(style: .Default, reuseIdentifier: "FNMatchPullTableViewCell")
        }
        cell?.contentView.backgroundColor = UIColor.init(red: 45/255.0, green: 45/255.0, blue: 45/255.0, alpha: 1)
        cell?.centerImageView.image = UIImage.init(named: NSString.init(format: "icn_%d", (indexPath.row+1)%3) as String)
        cell?.centerImageView.center = CGPointMake(view.bounds.size.width/2, 85)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
}
