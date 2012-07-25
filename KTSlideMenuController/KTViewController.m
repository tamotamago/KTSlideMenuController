//
//  KTViewController.m
//  KTSlideMenuController
//
//  Created by Tamura Koya on 12/07/24.
//  Copyright (c) 2012年 Koya Tamura. All rights reserved.
//

#import "KTViewController.h"
#import "KTMenuTalbeViewController.h"

@interface KTViewController ()

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, retain) IBOutlet UIView *dummyView;

@end

@implementation KTViewController

@synthesize isOpen =_isOpen;

@synthesize dummyView = _dummyView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    KTMenuTalbeViewController *menuTableViewController = 
    [self.storyboard instantiateViewControllerWithIdentifier:@"KTMenuTalbeViewController"];
    [menuTableViewController.view setFrame:_dummyView.frame];
    
    [self addChildViewController:menuTableViewController];
    [menuTableViewController didMoveToParentViewController:self];
    [self.view addSubview:menuTableViewController.view];
    
    UIViewController *viewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    [self setFirstViewController:viewController1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - setFirstViewController
-(void)setFirstViewController:(UIViewController *)viewController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] 
                                          initWithTitle:@"menu" 
                                          style:UIBarButtonItemStylePlain 
                                          target:self 
                                          action:@selector(slide:)];
    [viewController.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    //[navigationController.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    [self addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self];
    [self.view addSubview:navigationController.view];
}

-(void)removeFirstViewController
{

}

#pragma mark - slide
-(void)slide:(id)sender
{
    _isOpen = !_isOpen;
    
    UINavigationController *firstNavigationController = [self.childViewControllers objectAtIndex:1];
    UIView *firstView = firstNavigationController.view;
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat originX = _isOpen ? 200 : 0;
        CGRect frame = firstView.frame;
        frame.origin.x = originX;
        firstView.frame = frame;         
    } completion:^(BOOL finished){
        
    }];
}

@end
