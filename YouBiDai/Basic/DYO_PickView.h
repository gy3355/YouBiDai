

#import <UIKit/UIKit.h>

@protocol DYO_PickViewDelegate <NSObject>

//-(void)pickViewdidSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(void)pickViewdidSelect:(NSString *)selectStr;
@end

@interface DYO_PickView : UIButton

@property (nonatomic,weak)id<DYO_PickViewDelegate> delegate;

+(instancetype)defaultPick;

-(void)showWith:(NSArray *)arr list:(NSInteger)line;

@end
