//
//  DAPeriodPickerView.h
//  UIKitExtension
//
//  Copyright 2011 David Andreoletti. All rights reserved.
//

#import "DAPeriodPickerView.h"

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
/**
 * Private Protocol of class DAPeriodPickerView
 */
@interface DAPeriodPickerView ()

/**
 * Returns months Period as human readable string based on locale
 * @param row The selected row in the component
 * @return The month period.Eg: Jan-Feb
 */
- (NSString*) monthsPeriodForRow:(NSInteger)row;
/**
 * Returns year as human readable string based on locale
 * @param row The selected row in the component
 * @return The year.Eg: 2011
 */
- (NSString*) yearForRow:(NSInteger)row;

/**
 *  Returns the range of months for a given row
 *  @param row The row
 *  @return The range of months. 
 *  Eg: NSRange(0,2) means Jan-Feb
 *  NSRange(1,2) means Feb-Mar, 
 *  NSRange(2,1) means Mar only, 
 *  and NSRange(3,0) means no period
 */
-(NSRange) monthRangeForRow:(NSInteger)row;

/**
 *  Returns the range of years for a given row
 *  @param row The row
 *  @return The range of years. 
 *  Eg: NSRange(i,1) means the month at index i, 
 */
-(NSRange) yearRangeForRow:(NSInteger)row;

/**
 * Returns months period as human readable string based on the locale
 * @param range The month period
 * @param userLocale Locale to use
 * @return The month period.Eg: Jan-Feb
 */
-(NSString*) monthsPeriodAsHumanReadableString:(NSRange)range withLocale:(NSLocale*)userLocale;

/**
 * Returns year period as human readable string based on the locale
 * @param range The year period
 * @param userLocale Locale to use
 * @return The year period.Eg: 2011
 */
-(NSString*) yearPeriodAsHumanReadableString:(NSRange)range withLocale:(NSLocale*)userLocale;

@end

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
@implementation DAPeriodPickerView

#pragma mark -
#pragma mark Properties

@synthesize months;
@synthesize years;
@synthesize allowedMonthPeriods;
@synthesize locale;
@synthesize rowSelectionDelegate;

#pragma mark -
#pragma mark Object Memory Management

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
- (id)initWithMonths:(NSArray*)monthsAsArray 
 allowedMonthPeriods:(NSArray*)allowedMonthPeriodsAsArray
               years:(NSArray*)yearsAsArray
               locale:(NSLocale*)userLocale
{
    self = [super init];
    
    if (self == nil) {
        
        //LOGERROR(@"Super class cannot be instantiated!");
        
        [self release];
        
        return nil;
    }
    self.months = monthsAsArray;
    self.years = yearsAsArray;
    self.allowedMonthPeriods = allowedMonthPeriodsAsArray;
    self.locale = userLocale;
    
    self.dataSource = self;
    self.delegate = self;
    
    NSLog(@"Period Picker View created");
    return self;
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
- (void)dealloc { 
    [self.months release];
    [self.years release];
    [self.allowedMonthPeriods release];
    [self.locale release];
	[super dealloc];
}

#pragma mark -
#pragma mark UIPickerView

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //  If delegate is set then forward selected row in period picker view
    if(self.rowSelectionDelegate)
    {
        NSObject<DAPeriodPickerViewDelegate>* myDelegate = (NSObject<DAPeriodPickerViewDelegate>*)self.rowSelectionDelegate;
        if ([myDelegate conformsToProtocol:@protocol(DAPeriodPickerViewDelegate)])
        {
            [myDelegate periodPickerView:self didSelectRow:row inComponent:component];
        }
    }
}

#pragma mark -
#pragma mark UIPickerViewDataSource

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{  
    if (component == 0) {return [self.allowedMonthPeriods count];}
    if (component == 1) {return [self.years count];}
    return 0;
}

#pragma mark -
#pragma mark UIPickerViewDataDelegate

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = nil;
    switch (component) {
        case 0:
        {
            title = [self monthsPeriodForRow: row];
        }
            break;
        case 1:
        {
            title = [self yearForRow: row];
        }
            break;
        default:
            break;
    }
    return title;
}

#pragma mark -
#pragma mark DAPeriodPickerView (Private Protocol)

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//

- (NSString*) monthsPeriodForRow:(NSInteger)row
{
    NSRange range = [self monthRangeForRow:row];
    return [self monthsPeriodAsHumanReadableString:range withLocale:locale];
}

- (NSString*) yearForRow:(NSInteger)row
{
    NSRange range = [self yearRangeForRow:row];
    return [self yearPeriodAsHumanReadableString:range withLocale:locale];
}

-(NSRange) monthRangeForRow:(NSInteger)row
{ 
    NSRange range = [(NSValue*)[self.allowedMonthPeriods objectAtIndex:row] rangeValue];
    return range;
}

-(NSRange) yearRangeForRow:(NSInteger)row
{
    NSRange range = NSMakeRange(row, 1);
    return range;
}

-(NSString*) monthsPeriodAsHumanReadableString:(NSRange)range withLocale:(NSLocale*)userLocale
{
    //  Retrieve month from months
    NSUInteger month0AsInt = [(NSNumber*)[self.months objectAtIndex:range.location] unsignedIntValue];
    month0AsInt++; // since months are zero based indexed
    NSUInteger month1Index = range.location;
    if (range.length > 0)
    {
        month1Index = month1Index+range.length-1; // -1 since array zero based indexed
    }
    NSUInteger month1AsInt = [(NSNumber*)[self.months objectAtIndex:month1Index] unsignedIntValue];
    month1AsInt++; // since months are zero based-indexed
    //  Create month0 and month1 as International String Representation Format
    //  YYYY-MM-DD HH:MM:SS ±HHMM
    NSString* month0AsISRF = [NSString stringWithFormat:@"2001-%@-25 00:00:00 +0000", 
                             [NSString stringWithFormat:@"%d", month0AsInt]];
    NSString* month1AsISRF = [NSString stringWithFormat:@"2001-%@-25 00:00:00 +0000", 
                             [NSString stringWithFormat:@"%d", month1AsInt]];
    //  Create NSDate from month0
    NSDate* month0AsDate = [[[NSDate alloc] initWithString:month0AsISRF] autorelease];

    //  Create NSDate from month1
    NSDate* month1AsDate = [[[NSDate alloc] initWithString:month1AsISRF] autorelease];
    //  Convert month0.month and month1.month into date formatted with locale
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMM"];
    [dateFormatter setLocale:userLocale];
    NSString* month0WithLocaleFormat = [dateFormatter stringFromDate:month0AsDate];
    NSString* month1WithLocaleFormat = [dateFormatter stringFromDate:month1AsDate];
    NSString* monthPeriod = [NSString stringWithFormat:@"%@-%@", month0WithLocaleFormat, month1WithLocaleFormat];
    return monthPeriod;
}

-(NSString*) yearPeriodAsHumanReadableString:(NSRange)range withLocale:(NSLocale*)userLocale
{
    //  Retrieve year from years
    NSUInteger year0AsInt = [(NSNumber*)[self.years objectAtIndex:range.location] unsignedIntValue];
    NSUInteger year1Index = range.location;
    if (range.length > 0)
    {
        year1Index = year1Index + range.length-1; // -1 since array is zero based indexed
    }
    NSUInteger year1AsInt = [(NSNumber*)[self.years objectAtIndex:year1Index] unsignedIntValue];
    if(year0AsInt == year1AsInt)
    {
        //  Create year0 as International String Representation Format
        //  YYYY-MM-DD HH:MM:SS ±HHMM
        NSString* year0AsISRF = [NSString stringWithFormat:@"%@-02-25 00:00:00 +0000", 
                                [NSString stringWithFormat:@"%d", year0AsInt]];
        //  Create NSDate from year0
        NSDate* year0 = [[[NSDate alloc] initWithString:year0AsISRF] autorelease];
        //  Convert year0.year into date formatted with locale
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"YYYY"];
        [dateFormatter setLocale:userLocale];
        NSString* year0WithLocaleFormat = [dateFormatter stringFromDate:year0];
        return year0WithLocaleFormat;    
    }
    return nil;
}

@end
