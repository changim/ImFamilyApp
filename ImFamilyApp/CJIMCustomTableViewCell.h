//
//  CJIMCustomTableViewCell.h
//  ImFamilyApp
//
//  Created by James Im on 12/17/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJIMCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
