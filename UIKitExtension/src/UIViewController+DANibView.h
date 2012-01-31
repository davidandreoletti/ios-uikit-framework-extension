//
//  UIViewController+DANibView.h
//  UIKitExtension
//
//  Copyright 2011 David Andreoletti. All rights reserved.
//

/**
 *  Category to load nib/xib files
 *
 *  @author Original concept https://gist.github.com/379795
 *  @author David Andreoletti (davidandreoletti.com) - Extended and refactored category
 */
@interface UIViewController (DANibView)

/**
 *  Loads a UITableViewCell from a nib file in the main bundle
 *  @param nibName Name of the nib/xib file
 *  @param reusableCell Indicates if cell loaded is reusable (cell's identifier must then be equals to cell's nib filename)
 *  @return The cell loaded
 */
- (UITableViewCell *)loadTableViewCellFromNibNamed:(NSString *)nibName reusableCell:(BOOL) reusableCell;;

/**
 *  Loads a view from nib file
 *  @param clazz Class of View. Eg: UIView, UITableViewCell, etc
 *  @param nibName Nib filename
 *  @param owner Nib's file owner
 *  @param options Options used while load nib file.
 *  @param bundle Bundle to load nib from
  * @return The view loaded
 */
+ (UIView*)loadViewOfClass:(Class)clazz fromNibNamed:(NSString *)nibName withOwner:(id)owner withOptions:(NSDictionary*)options fromBundle:(NSBundle*) bundle;

@end
