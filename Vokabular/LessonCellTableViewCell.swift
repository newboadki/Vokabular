//
//  LessonCellTableViewCell.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 09/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit

class LessonCellTableViewCell: UITableViewCell
{

    // MARK: IB Outlets
    @IBOutlet weak var lessonTitle : UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: @selector(doit), name: name:UIContentSizeCategoryDidChangeNotification, object: nil)
//        UIApplication.Notifications.ObserveContentSizeCategoryChanged (delegate {
//            // text size has changed, reconfigure any UIViews's font here
//            
//            // Simple:
//            exampleLabel.font = UIFont.PreferredBody;
//            })
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
//    func doit() -> void
//    {
//        self.lessonTitle.
//    }
}
