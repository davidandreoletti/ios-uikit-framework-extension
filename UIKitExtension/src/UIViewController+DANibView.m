//
//  UIViewController+DANibView.m
//  UIKitExtension
//
//  Copyright 2011 David Andreoletti. All rights reserved.
//

#import "UIViewController+DANibView.h"


@implementation UIViewController (DANibView)

- (UITableViewCell *)loadTableViewCellFromNibNamed:(NSString *)nibName reusableCell:(BOOL) reusableCell;
{
    UITableViewCell* cell = (UITableViewCell* )
    [UIViewController loadViewOfClass:[UITableViewCell class]
                         fromNibNamed:nibName 
                          withOwner:self
                        withOptions:nil
                        fromBundle:[NSBundle mainBundle]];
    
    NSAssert1(cell.reuseIdentifier, 
              @"Cell in nib named %@ does not have a reuse identifier set", 
              nibName);
    NSAssert2([cell.reuseIdentifier isEqualToString:nibName], 
              @"Expected cell to have a reuse identifier of %@, but it was %@", 
              nibName, cell.reuseIdentifier);
    return cell;
}

+ (UIView*)loadViewOfClass:(Class)clazz fromNibNamed:(NSString *)nibName withOwner:(id)owner 
               withOptions:(NSDictionary*)options fromBundle:(NSBundle*) bundle;
{
    NSAssert1(bundle, @"|bundle| cannot be nil", nil);
    NSAssert1(nibName, @"|nibName| cannot be nil", nil);
    NSArray *bundleItems = [bundle loadNibNamed:nibName owner:owner options:options];
    id view = nil;
    for (id item in bundleItems) {
        if ([item isKindOfClass:clazz]) {
            view = item;
            break;
        }
    }
    NSAssert2(view, @"Expected nib named %@ to contain a with class %@", 
              nibName, NSStringFromClass([NSArray class]));
    return view;
}

@end
