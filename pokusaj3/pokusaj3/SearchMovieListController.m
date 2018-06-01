//
//  SearchMovieListController.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 31/05/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "SearchMovieListController.h"
#import "SearchViewCell.h"
#import "TMDbClass.h"

@interface SearchMovieListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *movieList;
@property (nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSString *query;

@end

@implementation SearchMovieListController

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 677"]];    self.tableView.dataSource = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchBar.delegate = self;
    
    self.navigationItem.titleView = self.searchBar;
    UINib *cellNib = [UINib nibWithNibName:@"SearchViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"SearchViewCell"];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"SearchViewCell";
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setupWithMovie:[self.movieList objectAtIndex:indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    NSInteger numberOfRows = 4.3;
    CGFloat rowHeight = screenWidth /numberOfRows;
    return rowHeight;
}

#pragma UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(searchBar.text != nil){
        TMDbClass *tmbdClass = [[TMDbClass alloc] init];
        [tmbdClass getListOfMoviesWithSuccess:^(NSArray *array) {
            NSLog(@"\n ovo jeee %@ \n", self.searchBar.text);
            self.movieList = array;
            [self.tableView reloadData];
        } withQuery:self.searchBar.text];
    }
}



@end
