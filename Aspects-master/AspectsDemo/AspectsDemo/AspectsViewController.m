//
//  AspectsViewController.m
//  AspectsDemo
//
//  Created by Peter Steinberger on 05/05/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AspectsViewController.h"
#import "Aspects.h"
#import <objc/runtime.h>

@interface Test1 : NSObject
@end
@implementation Test1

- (void)test{
    NSLog(@"Test1 test");
}

@end

@interface Test2 : NSObject

@end
@implementation Test2

- (void)test{
    NSLog(@"Test2 test");
}

@end


@implementation AspectsViewController
- (void)viewWillAppear:(BOOL)animated {
    
}
- (IBAction)buttonPressed:(id)sender {
    UIViewController *testController = [[UIImagePickerController alloc] init];

    testController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:testController animated:YES completion:NULL];

    // We are interested in being notified when the controller is being dismissed.
//    [testController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:0 usingBlock:^(id<AspectInfo> info, BOOL animated) {
//        UIViewController *controller = [info instance];
//        if (controller.isBeingDismissed || controller.isMovingFromParentViewController) {
//            [[[UIAlertView alloc] initWithTitle:@"Popped" message:@"Hello from Aspects" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
//        }
//    } error:NULL];
//
//    // Hooking dealloc is delicate, only AspectPositionBefore will work here.
//    [testController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info) {
//        NSLog(@"Controller is about to be deallocated: %@", [info instance]);
//    } error:NULL];
    
//    Class cls = object_getClass([Test1 class]);
//
//    [cls aspect_hookSelector:@selector(test) withOptions:2 usingBlock:^(id<AspectInfo> info){
//        NSLog(@"aspect_hookSelector test1");
//    } error:nil];
//
//    [Test1 test];
    
    Test1 * t1 = [Test1 new];
    [t1 aspect_hookSelector:@selector(test) withOptions:2 usingBlock:^(id<AspectInfo> info){
        NSLog(@"aspect_hookSelector test1");
    } error:nil];
    
    
    Class cls = object_getClass(t1);
    NSLog(@"%@ %p",cls,cls);
    Test1 * t2 = [Test1 new];
    [t2 aspect_hookSelector:@selector(test) withOptions:2 usingBlock:^(id<AspectInfo> info){
        NSLog(@"aspect_hookSelector test2");
    } error:nil];
    [t2 test];
}

@end

