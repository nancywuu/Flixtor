//
//  DetailsViewController.h
//  Flixter
//
//  Created by Nancy Wu on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailSynopsis;
@property (nonatomic, strong) NSDictionary *detailDict;

@end

NS_ASSUME_NONNULL_END
