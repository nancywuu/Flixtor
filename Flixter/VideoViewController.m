//
//  VideoViewController.m
//  Flixter
//
//  Created by Nancy Wu on 6/17/22.
//

#import "VideoViewController.h"

@interface VideoViewController ()
@property (nonatomic, strong) NSArray *videoData;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchKey];
}

- (void)fetchKey {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@/%s", "https://api.themoviedb.org/3/movie/", self.detailDict[@"id"], "/videos?api_key=c66206f4dfff53696b47dcc5387cc067&language=en-US"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                          message:@"The internet connection appears to be offline."
                                          preferredStyle:UIAlertControllerStyleAlert];

               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * action) {}];

               [alert addAction:defaultAction];
               [self presentViewController:alert animated:YES completion:nil];
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
//               NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
               self.videoData = dataDictionary[@"results"];
               NSDictionary *dict = self.videoData[0];
               //NSLog(dict[@"key"]);
               [self.playerView loadWithVideoId:dict[@"key"]];
           }
       }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
