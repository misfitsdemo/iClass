#import <Foundation/Foundation.h>

@class DBSUser, DBSLecture, DBSNote, DBSMessage;

@interface DBSScheduleService : NSObject
{
    NSDictionary *storage;
    NSMutableArray *weekLectures;
    NSMutableArray *weekNotes;
    NSMutableArray *messages;
}

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;

- (int)getWeekDay;
- (NSArray*)getWeekLectures;
- (NSDictionary*)getDayLectures:(int)day;
- (NSArray*)getWeekNotes;
- (NSDictionary*)getDayNotes:(int)day;
- (NSArray*)getMessages;

- (void)getLecturesOfWeek:(NSDictionary*)user
              currentWeek:(NSUInteger)currentWeek;

- (void)sortLecturesByVersionAndTime;

- (void)getNotesOfWeekAndMessages: (NSDictionary*)user
                      currentWeek: (NSUInteger)currentWeek;

- (DBSLecture*)createLecture:(NSDictionary*)dict;

- (DBSLecture*)createLectureEvent:(NSDictionary*)dict;

- (void)createNote:(NSDictionary*)dict;

- (void)createMessage:(NSDictionary*)dict;

- (DBSLecture*)updateLecture:(NSDictionary*)dict;

-(int)timeStringToTimeInt:(NSString *)stringNum;


- (NSString*)itemArchivepath;

- (BOOL)saveChanges;

@end
