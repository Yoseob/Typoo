//
//  FonteEditViewController.m
//  Typoo
//
//  Created by LeeYoseob on 2015. 8. 12..
//  Copyright (c) 2015년 LeeYoseob. All rights reserved.
//

#import "FontEditViewController.h"

@implementation FontEditViewController
{
    EditViewController * superVc;
    UIView * containerView;
    NSMutableArray * fontList;
    UITextView * textView ;
    
}
-(void)setSuperViewController:(UIViewController *)sender withView:(UIView*)view withHeight:(CGFloat)height{
    superVc = (EditViewController*)sender;
    [sender addChildViewController:self];
    
    UITableView * tableview= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [tableview reloadData];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    tableview.tag = font_edit;
    tableview.hidden = YES;
    [view addSubview:tableview];
    //Avantfatlove.ttf  /HomemadeApple
    fontList = [[NSMutableArray alloc]initWithArray:@[@"AnjelikaRose",
                                                      @"AmaticSC-Regular",
                                                      @"Aquarion",
                                                      @"AvantGardeITCbyBT-Book",
                                                      @"Avenir-Medium",
                                                      @"AveriaSerif-Regular",
                                                      @"Bazar",
                                                      @"Bebas",
                                                      @"BelleroseLight",
                                                      @"Blackout-Sunrise",
                                                      @"Blanch-Caps",
                                                      @"BPdots",
                                                      @"BrainFlower",
                                                      @"Captureit",
                                                      @"ChunkFiveEx",
                                                      @"Comfortaa",
                                                      @"Conviction",
                                                      @"Designosaur",
                                                      @"Duke-Regular",
                                                      @"Fjord-One",
                                                      @"Folk-solid",
                                                      @"Futura-CondensedMedium",
                                                      @"GearedSlab-Bold",
                                                      @"GeosansLight",
                                                      @"GothamBold",
                                                      @"GrandesignNeueSerif",
                                                      @"Gretoon",
                                                      @"Haymaker",
                                                      @"HelveticaNeue-Bold",
                                                      @"Highlands-Regular",
                                                      @"Homestead-Display",
                                                      @"Intro",
                                                      @"JoyfulJuliana",
                                                      @"JUICERegular",
                                                      @"Klavika-Bold",
                                                      @"Knewave",
                                                      @"Knochen-Ultra",
                                                      @"LaurenCBrown",
                                                      @"LightuptheWorld",
                                                      @"LiveSimply",
                                                      @"Lobster1.4",
                                                      @"Magenta",
                                                      @"MarketDeco",
                                                      @"Mate-Regular"]];
    

}
-(void)setTargetTextView:(UITextView*)targerView{
    textView=targerView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FontTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        NSLog(@"cell");
    
        cell = [[FontTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    NSString * fontName = fontList[indexPath.row];
    NSLog(@"%@",fontName);
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text= fontName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:fontName size:20];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return fontList.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    textView.font = [UIFont fontWithName:fontList[indexPath.row] size:30];

}
@end
