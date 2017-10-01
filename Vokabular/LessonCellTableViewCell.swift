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
    @IBOutlet weak var vieButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
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
        
        NotificationCenter.default().addObserver(self, selector: #selector(LessonCellTableViewCell.preferredContentSizeChanged(_:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

    }

    func preferredContentSizeChanged(_ notif : Notification) {
        if #available(iOS 9.0, *) {
            self.lessonTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleTitle3)
            self.vieButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleCallout)
            self.testButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleCallout)
            self.lessonTitle.setNeedsUpdateConstraints()
            self.vieButton.setNeedsUpdateConstraints()
            self.testButton.setNeedsUpdateConstraints()

        } else {
            // Fallback on earlier versions
        };


    }

//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        if #available(iOS 9.0, *) {
//            self.lessonTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleTitle3)
//            self.vieButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleCallout)
//            self.testButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleCallout)
//
//            self.lessonTitle.setNeedsDisplay()
//            self.vieButton.setNeedsDisplay()
//            self.testButton.setNeedsDisplay()
//            
//            
//        } else {
//            // Fallback on earlier versions
//        }
//
//    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
//    func doit() -> void
//    {
//        self.lessonTitle.
//    }
}
