//
//  VideoViewController.h
//  Flixter
//
//  Created by Nancy Wu on 6/17/22.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : UIViewController
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (nonatomic, strong) NSDictionary *detailDict;

@end

NS_ASSUME_NONNULL_END
