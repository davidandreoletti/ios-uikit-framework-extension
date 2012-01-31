//
//  DAPeriodPickerView.h
//  UIKitExtension
//
//  Copyright 2011 David Andreoletti. All rights reserved.
//

#import "DAPeriodPickerViewDelegate.h"

//  Apple
#import <Foundation/Foundation.h>

/**
 *  Period Picker View displaying time periods (eg: Jan-Feb 2011, Mar-Apr 2012)
 *
 *  @author David Andreoletti (davidandreoletti.com)
 */
@interface DAPeriodPickerView : UIPickerView 
<
UIPickerViewDataSource,
UIPickerViewDelegate
>
{
@public

    /**
     *  Period Picker Delegate
     */
    id<DAPeriodPickerViewDelegate> rowSelectionDelegate;
    
    /**
     *  Component 0 (Months)
     */
    NSArray* months;
    
    /**
     *  List of allowed Periods for Component 0
     */
    NSArray* allowedMonthPeriods;
    
    /**
     *  Component 1 (year)
     */
    NSArray* years;
    
    /**
     *  Locale to use for month period/year strings
     */
    NSLocale* locale;
}

@property (nonatomic, retain) NSArray *months;
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, retain) NSArray *allowedMonthPeriods;
@property (nonatomic, retain) NSLocale *locale;
@property (nonatomic, assign) id<DAPeriodPickerViewDelegate> rowSelectionDelegate;

/**
 *  Default Constructor
 *  @param months. Array of months for component months0. Must be an instance of
 *  NSArray containing <NSNumber as uint> instances
 *  @param allowedMonthPeriodsAsArray Contains all month periods to display. 
 *  A month period is represented as a NSRange(i,j) where i is the index 
 *  of the month in |months| and j is the number of months in this period. 
 *  j=0 means the period is empty. j=1 means the period contains 1 month 
 *  only which is the one at index i. j=2 means the month at index i and 
 *  the month at index i+1
 *  @param years. Array of years for component year. It msut be an instance of 
 * NSArray containing <NSNumber as uint> instances
 *  @return The Period Picker View instance
 */
- (id)initWithMonths:(NSArray*)monthsAsArray 
 allowedMonthPeriods:(NSArray*)allowedMonthPeriodsAsArray
               years:(NSArray*)yearsAsArray
               locale:(NSLocale*)locale;

@end
