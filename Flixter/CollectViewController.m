//
//  CollectViewController.m
//  Flixter
//
//  Created by Nancy Wu on 6/16/22.
//

#import "CollectViewController.h"
#import "GridCells.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface CollectViewController ()<UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    // Do any additional setup after loading the view.
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=c66206f4dfff53696b47dcc5387cc067"];
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
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
               
//               NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
               self.myArray = dataDictionary[@"results"];
               //NSLog(@"%@", self.myArray);
//               for(int i = 1; i < sizeof(myArray); i++){
//                   NSLog(@"%@", myArray[i][@"title"]);
//               }
               [self.collectionView reloadData];
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GridCells *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"gridCellIdent" forIndexPath:indexPath];
    NSDictionary *dict = self.myArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", "https://image.tmdb.org/t/p/w500", dict[@"poster_path"]]];
    [cell.cellImage setImageWithURL:url];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myArray.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GridCells *cell = sender;
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];
//     Pass the selected object to the new view controller.
    NSDictionary *dataToPass = self.myArray[path.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
}


@end
