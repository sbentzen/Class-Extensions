//
//  TableViewCells.m
//  MySudbury
//
//  Created by Shaun on Wednesday, January 26 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import "TableViewCells.h"
#import "Definitions.h"

@implementation rssCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setSelectionStyle:UITableViewCellSelectionStyleGray];
        [[self textLabel] setTextColor:defaultColor];
        [[self textLabel] setFont:defaultFont];
        [[self textLabel] setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

@end
