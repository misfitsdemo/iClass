#import "DBSNote.h"

@implementation DBSNote

@synthesize text = _text;
@synthesize week = _week;
@synthesize day = _day;
@synthesize courseID = _courseID;

+(id) noteWithText:(NSString *)text
              week:(NSString *)week
               day:(NSString *)day
          courseID:(NSString *)courseID{
    return [[self alloc]initNoteWithText:text
                                    week:week
                                     day:day
                                courseID:courseID];
}

-(id) initNoteWithText:(NSString *)text
                  week:(NSString *)week
                   day:(NSString *)day
              courseID:(NSString *)courseID{
    if(self = [super init])
    {
        _text = text;
        _week = week;
        _day = day;
        _courseID = courseID;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Text: %@, Week: %@, Day: %@, CourseID: %@",
            self.text,
            self.week,
            self.day,
            self.courseID];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: _courseID forKey:@"courseID"];
    [aCoder encodeObject: _week forKey:@"week"];
    [aCoder encodeObject: _day forKey:@"day"];
    [aCoder encodeObject: _text forKey:@"text"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setCourseID:[aDecoder decodeObjectForKey:@"courseID"]];
        [self setWeek:[aDecoder decodeObjectForKey:@"week"]];
        [self setDay:[aDecoder decodeObjectForKey:@"day"]];
        [self setText:[aDecoder decodeObjectForKey:@"text"]];
    }
    return self;
}

@end