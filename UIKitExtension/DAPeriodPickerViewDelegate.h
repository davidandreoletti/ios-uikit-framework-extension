//
//  DAPeriodPickerViewDelegate.h
//  UIKitExtension
//
//  Copyright 2011 David Andreoletti. All rights reserved.
//

@class DAPeriodPickerView;

//  Apple
#import <Foundation/Foundation.h>

/**
 *  Period Picker View Delegate
 *
 *  @author David Andreoletti (davidandreoletti.com)
 */
@protocol DAPeriodPickerViewDelegate<NSObject>

@required

/**
 *  Called by the picker view when the user selects a row in a component.
 *  @param pickerView An object representing the picker view requesting the data.
 *  @param row A zero-indexed number identifying a row of component. Rows are numbered top-to-bottom.
 *  @param component A zero-indexed number identifying a component of pickerView. Components are numbered left-to-right.
 *  Discussion
 *  To determine what value the user selected, the delegate uses the row index to access 
 *  the value at the corresponding position in the array used to construct the component.
 */
- (void)periodPickerView:(DAPeriodPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
