//
//  ViewController.swift
//  PullToRefreshKit
//
//  Created by huangwenchen on 16/7/11.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit
import AudioToolbox
/* 
    如果你喜欢这个库，一个★就是对我最好的支持，项目地址 https://github.com/LeoMobileDeveloper/PullToRefreshKit
 */
class MainViewController: UITableViewController {
    var models = [SectionModel]()
    override func viewDidLoad() {
        let section0 = SectionModel(rowsCount: 5,
                                    sectionTitle:"Default",
                                    rowsTitles: ["Tableview","CollectionView","ScrollView","Banners","WebView"],
                                    rowsTargetControlerNames:["DefaultTableViewController","DefaultCollectionViewController","DefaultScrollViewController","DefaultBannerController","DefaultWebViewController"])
        let section1 = SectionModel(rowsCount: 1,
                                    sectionTitle:"Build In",
                                    rowsTitles: ["Elastic",],
                                    rowsTargetControlerNames:["ElasticHeaderTableViewController"])
        
        let section2 = SectionModel(rowsCount: 2,
                                    sectionTitle:"Config Default",
                                    rowsTitles: ["Header/Footer","Left/Right"],
                                    rowsTargetControlerNames:["ConfigDefaultHeaderFooterController","ConfigBannerController"])
        let section3 = SectionModel(rowsCount: 6,
                                    sectionTitle:"Customize",
                                    rowsTitles: ["YahooWeather","Curve Mask","Youku","TaoBao","QQ Video","DianPing"],
                                    rowsTargetControlerNames:["YahooWeatherTableViewController","CurveMaskTableViewController","YoukuTableViewController","TaobaoTableViewController","QQVideoTableviewController","DianpingTableviewController"])
        models.append(section0)
        models.append(section1)
        models.append(section2)
        models.append(section3)
        self.tableView.setUpHeaderRefresh { [weak self] in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.tableView.endHeaderRefreshing(.Success,delay:0.3)
            }
        }
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return models.count
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionModel = models[section]
        return sectionModel.sectionTitle
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = models[section]
        return sectionModel.rowsCount
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        let sectionModel = models[indexPath.section]
        cell?.textLabel?.text = sectionModel.rowsTitles[indexPath.row]
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sectionModel = models[indexPath.section]
        var className = sectionModel.rowsTargetControlerNames[indexPath.row]
        className = "PullToRefreshKit.\(className)"
        if let cls = NSClassFromString(className) as? UIViewController.Type{
            let dvc = cls.init()
            self.navigationController?.pushViewController(dvc, animated: true)
        }

    }
}

