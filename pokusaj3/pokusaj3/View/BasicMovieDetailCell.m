//
//  BasicMovieDetailCell.m
//  pokusaj3
//
//  Created by Atlantbh Guest on 04/06/2018.
//  Copyright © 2018 Atlantbh Guest. All rights reserved.
//

#import "BasicMovieDetailCell.h"

@implementation BasicMovieDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor blackColor];
    
    self.starsLabel.numberOfLines = 0;
    [self.starsLabel sizeToFit];
    
    self.writersLabel.numberOfLines = 0;
    [self.writersLabel sizeToFit];
    
    self.shortDescriptionLabel1.numberOfLines = 4;
    [self.shortDescriptionLabel1 sizeToFit];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setupWithMovieDetails:(MovieDetails *)movieDetails {
    self.shortDescriptionLabel1.text = movieDetails.shortDescription;
    self.voteAverageLabel.text = movieDetails.voteAverageString;
}
-(void) setupWIthCredits:(Credits *)credits{
    if(credits != nil){
        NSString *futureLabel = @"";
        for(int i = 0; i < credits.actorsList.count && i < 3; i++){
            Actor *ac = credits.actorsList[i];
            futureLabel =[futureLabel stringByAppendingString:ac.name];
            if(i < credits.actorsList.count -1 && i !=2){
                futureLabel =[futureLabel stringByAppendingString:@", "];
            }
        }
        self.starsLabel.text = futureLabel;
        futureLabel = @"";
        int numberOfWriters = 0;
        for(int i = 0; i < credits.crewList.count && numberOfWriters < 3; i++){
            CrewMember *cm = credits.crewList[i];
            if([cm.job isEqualToString:@"Screenplay"] || [cm.job isEqualToString:@"Writer"] ){
                futureLabel =[futureLabel stringByAppendingString:cm.name];
                
                if(i < credits.actorsList.count -1 && numberOfWriters < 2){
                    futureLabel =[futureLabel stringByAppendingString:@", "];
                }
                numberOfWriters++;
                
            }
        }
        
        self.writersLabel.text = futureLabel;
        for(int i = 0; i < credits.crewList.count; i++){
            CrewMember *cm = credits.crewList[i];
            if([cm.job isEqualToString:@"Director"]){
                self.directorLabel.text = cm.name;
                break;
            }
        }
    }
}

@end
