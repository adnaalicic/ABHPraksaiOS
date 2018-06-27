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
   
    UINib *cellNib = [UINib nibWithNibName:@"SearchViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"SearchViewCell"];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    
    
    self.navigationItem.titleView = searchBar;
    [searchBar becomeFirstResponder];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
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
    return 91.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showingDetailsFromTable" sender:self];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];


}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.identifier isEqualToString:@"showingDetailsFromTable"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        MovieDetailTableViewController *destViewController = segue.destinationViewController;
        Movie *m = [self.movieList objectAtIndex:indexPath.row];
        
        destViewController.movieId= m.identity;
    }
}
#pragma UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if(searchBar.text != nil){
        TMDbClass *tmbdClass = [[TMDbClass alloc] init];
        [tmbdClass getListOfMoviesWithSuccess:^(NSArray *array) {
            self.movieList = array;
            
            [self.tableView reloadData];
            
        } withQuery:searchBar.text];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     [searchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self performSegueWithIdentifier:@"backToMainView" sender:self];

    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length >= 3){
        TMDbClass *tmbdClass = [[TMDbClass alloc] init];
        [tmbdClass getListOfMoviesWithSuccess:^(NSArray *array) {
            self.movieList = array;
            
            [self.tableView reloadData];
            
        } withQuery:searchBar.text];
    }
    if(searchText.length == 0){
        self.movieList = nil;
        [self.tableView reloadData];
    }
}

@end
