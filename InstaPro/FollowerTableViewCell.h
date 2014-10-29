//
//  FollowerTableViewCell.h
//  InstaPro
//
//  Created by Bradley Walker on 10/29/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FollowerTableViewDelegate
-(void)followImageTapped;
@end


@interface FollowerTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *followIcon;

@property id<FollowerTableViewDelegate> delegate;
@end
