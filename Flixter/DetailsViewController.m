//
//  DetailsViewController.m
//  Flixter
//
//  Created by Nancy Wu on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailTitle.text = self.detailDict[@"title"];
    self.detailSynopsis.text = self.detailDict[@"overview"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", "https://image.tmdb.org/t/p/w500", self.detailDict[@"poster_path"]]];
    [self.detailImage setImageWithURL:url];
    [self.backImage setImageWithURL:url];
//    self.detailImage.layer.borderWidth = 1.5;
//    self.detailImage.layer.borderColor = UIColor.white.cgColor;
//    self.detailImage.layer.cornerRadius = imageView.bounds.width / 2;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //MovieTableViewCell *cell = sender;
//    NSIndexPath *path = [self.tableView indexPathForCell:cell];
////     Pass the selected object to the new view controller.
    NSDictionary *dataToPass = self.detailDict;
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
}

@end
