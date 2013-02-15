//
//  DailieOverviewViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/11/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailiesOverviewViewController.h"
#import "ContactViewController.h"
#import "XMLDailiesParser.h"
#import "DailyOverviewSectionCell.h"

@interface DailiesOverviewViewController ()
@end



@implementation DailiesOverviewViewController

@synthesize userName, userPassword, headerView, footerView, logoutBtn, loginUserName, projectIdent, myCollectionView;

XMLDailiesParser *xmlDailiesParser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg_pl.png"]];
    self.loginUserName.text = self.userName;
    [self.overviewBtn setSelected:YES];
    
    xmlDailiesParser = [[XMLDailiesParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/dailies.xml" AndProjectIdent:projectIdent AndUserName:userName AndPassword:userPassword];
    
    /*
    for (Daily *daily in [xmlDailiesParser dailies]) {
        for (Clip *clip in daily.clips) {
            NSLog(@"clipName: %@", clip.clipName);
        }
    }
    */
    
    [self.myCollectionView registerClass:[DailyOverviewSectionCell class] forCellWithReuseIdentifier:@"SectionCell"];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.myCollectionView.collectionViewLayout;
    //flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    flowLayout.itemSize = CGSizeMake(256, 144);
    flowLayout.minimumInteritemSpacing = 0;
        
    
    [self.myCollectionView reloadData];
    
    NSLog(@"xmlDailiesParser finisht.........");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    Daily *dailySection = [[xmlDailiesParser dailies] objectAtIndex:section];
    NSInteger numClipsInDaily = [[dailySection clips] count];
    return (numClipsInDaily > 0) ? numClipsInDaily : numClipsInDaily + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //check if sectionStart
    Daily *currentDaily = [[xmlDailiesParser dailies] objectAtIndex:indexPath.section];
    NSMutableArray *dailyClips = [currentDaily clips];
    Clip *currentClip = [dailyClips objectAtIndex:indexPath.row];
    
    //NSLog(@"-----------");
    //NSLog(@"idexPath.Section --->%i", indexPath.section);
    //NSLog(@"idexPath.row --->%i", indexPath.row);
    
    
    static NSString *identifier;
    if (indexPath.row == 0) {
        identifier = @"SectionCell";
        DailyOverviewSectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        [cell setSectionTitel:currentDaily.name];
        return cell;
        
    }else {
        identifier = @"overviewCell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *dailyTitel = (UILabel *) [cell viewWithTag:110];
        dailyTitel.text = currentClip.clipName;
        
        UIImageView *clipImageView = (UIImageView *)[cell viewWithTag:100];
        
        NSURL *url = [NSURL URLWithString:currentClip.thumbnail_path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        clipImageView.image = image;
        return cell;

    }
    
    return nil;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[xmlDailiesParser dailies] count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item %d", indexPath.row);
}




- (IBAction)contactBtnClick:(id)sender {
    
    NSLog(@"contactBtnClick-----");
    [self performSegueWithIdentifier:@"fromDailiesOverviewToContact" sender:self];
}

- (IBAction)dailiesBtnClick:(id)sender {
    NSLog(@"dailiesBtnClick-----");
    //[self performSegueWithIdentifier:@"fromDailiesOverviewToProjectList" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)overviewBtnClick:(id)sender {
    NSLog(@"overviewBtnClick-----");
}

- (IBAction)logoutBtnClick:(id)sender {
    
    NSLog(@"logoutBtnClick-----");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"switchValue"];
    
    [self performSegueWithIdentifier:@"fromDailiesOverviewToStart" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToContact"]){
        
        ContactViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
    }
}


@end
