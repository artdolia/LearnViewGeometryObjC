//
//  ADViewController.m
//  Lesson19_HW
//
//  Created by A D on 1/2/14.
//  Copyright (c) 2014 AD. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()

@property (strong, nonatomic) NSMutableSet *blackCells;
@property (strong, nonatomic) NSMutableSet *whiteCheckers;
@property (strong, nonatomic) NSMutableSet *redCheckers;
@property (strong, nonatomic) UIView *board;

@end

@implementation ADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /******************** LEVEL SUPERMAN **********************/

    self.blackCells = [NSMutableSet set];
    self.redCheckers = [NSMutableSet set];
    self.whiteCheckers = [NSMutableSet set];
    
    NSInteger viewWidth = CGRectGetWidth(self.view.bounds);
    NSInteger viewHeight = CGRectGetHeight(self.view.bounds);
    
    NSInteger boardSide = MIN(viewHeight, viewWidth);
    NSInteger cellSide = boardSide/8.0f;

    self.board = [[UIView alloc] initWithFrame:CGRectMake(viewHeight > viewWidth ? 0 : (viewWidth - viewHeight)/2,
                                                          viewHeight < viewWidth ? 0 : (viewHeight - viewWidth)/2,
                                                          boardSide, boardSide)];
    self.board.backgroundColor = [UIColor grayColor];
    
    self.board.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.view addSubview:self.board];
    
    NSInteger boardOriginCoordX = CGRectGetMinX(self.board.bounds);
    NSInteger boardOriginCoordY = CGRectGetMinY(self.board.bounds);
    
    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            
            if ((i%2==0 && j%2==1) || (i%2==1 && j%2==0)) {
            
                CGRect viewRect = CGRectMake(boardOriginCoordX+(j*cellSide), boardOriginCoordY+(i*cellSide), cellSide, cellSide);
                
                [self makeViewWithRect:viewRect andParent:self.board andColor:[UIColor blackColor] andAddIndexToSet:self.blackCells];
            
                if(i < 3){
                    CGRect viewRect = CGRectMake(boardOriginCoordX + cellSide/4 + (j*cellSide), boardOriginCoordY+ cellSide/4 + (i*cellSide),cellSide/2, cellSide/2);
                    
                    [self makeViewWithRect:viewRect andParent:self.board andColor:[UIColor whiteColor] andAddIndexToSet:self.whiteCheckers];
                    
                }else if(i > 4){
                    
                    CGRect viewRect = CGRectMake(boardOriginCoordX+ cellSide/4 + (j*cellSide),boardOriginCoordY+ cellSide/4 + (i*cellSide), cellSide/2, cellSide/2);
                    
                    [self makeViewWithRect:viewRect andParent:self.board andColor:[UIColor redColor] andAddIndexToSet:self.redCheckers];
                }
            }
        }
    }
}

/******************** LEVEL SUPERMAN PART 2 - METHODS **********************/


#pragma  mark - Rotation -

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{

    [self setColor:[self randomColor] toViewsWithIndexes:self.blackCells fromSubviewsof:self.board];

    [self setColor:nil toViewsWithIndexes:self.whiteCheckers  fromSubviewsof:self.board];

    [self setColor:nil toViewsWithIndexes:self.redCheckers  fromSubviewsof:self.board];
}


#pragma mark - makeView and setColor -

-(void) makeViewWithRect:(CGRect) viewRect andParent:(UIView*) parentView andColor:(UIColor*) color andAddIndexToSet:(NSMutableSet*)set{
    
    UIView *customView = [[UIView alloc] initWithFrame:viewRect];
    
    customView.backgroundColor = color;
    
    [parentView addSubview:customView];
    
    [set addObject:[NSNumber numberWithInt:[parentView.subviews indexOfObject:customView]]];
}

-(void) setColor:(UIColor *) color toViewsWithIndexes:(NSMutableSet *) set fromSubviewsof:(UIView *)parentView {
    
    for(NSNumber *number in set){
        
        UIColor *backgroundColor = [[UIColor alloc] init];
        
        if(color == nil) {
            
            backgroundColor = arc4random()%2 ? [UIColor whiteColor] : [UIColor redColor];
        
        }else{
            
            backgroundColor = color;
        }
        
        UIView *customView = [parentView.subviews objectAtIndex:[number integerValue]];
        customView.backgroundColor = backgroundColor;
    }
}


#pragma mark - colorMethods -

-(UIColor *) randomColor{
    
    return [UIColor colorWithRed:[self randIntForColor] green:[self randIntForColor] blue:[self randIntForColor] alpha: 1.0f ];
}

-(CGFloat) randIntForColor{
    
    return (float)(arc4random()%256)/255;
}







@end

















