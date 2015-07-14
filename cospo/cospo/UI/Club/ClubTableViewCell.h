//
//  ClubTableViewCell.h
//  cospo
//
//  Created by gwc on 15/7/6.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClubTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *club_image;
@property (strong, nonatomic) IBOutlet UILabel *club_name;
@property (strong, nonatomic) IBOutlet UIImageView *clbu_cover_one;
@property (strong, nonatomic) IBOutlet UIImageView *club_cover_two;
@property (strong, nonatomic) IBOutlet UIImageView *club_cover_three;
@property (strong, nonatomic) IBOutlet UIView *club_BG;
@property (strong, nonatomic) IBOutlet UIView *botton_view;


@end
