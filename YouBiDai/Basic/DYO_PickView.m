
//

#import "DYO_PickView.h"


@interface DYO_PickView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger list;               // 多少列数据
@property (nonatomic, strong) NSArray *titleOneArr;
@property (nonatomic, strong) NSDictionary *titleTwoDic;
@property (nonatomic, strong) NSDictionary *titleThirdDic;

@property(copy,nonatomic) NSString* selectStrOne;
@property(copy,nonatomic) NSString* selectStrTwo;
@property(copy,nonatomic) NSString* selectStrThird;

@end


@implementation DYO_PickView

#pragma mark 实例化
+ (instancetype)defaultPick {
    DYO_PickView *pick = [DYO_PickView buttonWithType:UIButtonTypeCustom];
    pick.frame = CGRectMake(0, 0, SCREEN_S.width, SCREEN_S.height);
    pick.backgroundColor = GM_COLOR(70, 70, 70, 0.3);
    pick.list = 1;
    [pick setSubViews];
    return pick;
}
- (void)setSubViews {
    CGFloat buttonFontSize = 18;

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.pickerView.frame)-40, SCREEN_S.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_S.width, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:line];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel.titleLabel setFont:[UIFont systemFontOfSize:buttonFontSize]];
    cancel.frame = CGRectMake(0, 0, 80, 40);
    [cancel setTitleColor:GM_BlueColor forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:buttonFontSize]];
    sureBtn.frame = CGRectMake(SCREEN_S.width - 80, 0, 80, 40);
    [sureBtn setTitleColor:GM_BlackColor forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didSelectPick) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:cancel];
    [view addSubview:sureBtn];
    [view addSubview:line];
    [self addSubview:view];
    [self addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 显示PickerView
- (void)showWith:(NSArray *)arr list:(NSInteger)line {
    
    [[[UIApplication sharedApplication].delegate window]addSubview:self];
    [self addSubview:self.pickerView];

    self.titleOneArr = nil;
    self.titleTwoDic = nil;
    self.titleThirdDic = nil;
    self.titleOneArr = nil;
    self.titleTwoDic = nil;
    self.titleThirdDic = nil;
    
    self.list = line;
    self.titleOneArr = arr[0];
    
    
    if (line == 2) {
        self.titleTwoDic  = arr[1] ;
    }
    
    if (line == 3) {
        self.titleTwoDic  = arr[1] ;
        self.titleThirdDic  = arr[2] ;
    }
    
     [self.pickerView reloadAllComponents];
}
#pragma mark 隐藏PickerView
- (void)hideSelf {
    [self removeFromSuperview];
    self.pickerView = nil;
}


#pragma mark 按钮点击事件
// "取消"按钮点击
- (void)cancelSelect {
    [self hideSelf];
}
// "确定"按钮点击
- (void)didSelectPick {
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    self.selectStrOne = self.titleOneArr[row1];
    NSMutableString *mutStr = [NSMutableString stringWithString:self.selectStrOne];
    
    if (self.list == 2) {
        NSInteger row2 = [self.pickerView selectedRowInComponent:1];
        NSArray *twoArr  =  [self.titleTwoDic valueForKey:self.selectStrOne];
        if (twoArr!=nil && twoArr.count>0) {
            [mutStr appendString:[NSString stringWithFormat:@",%@", twoArr[row2]]];
        }
    }
    if (self.list == 3) {
        
        NSInteger row2 = [self.pickerView selectedRowInComponent:1];
        NSArray *twoArr  =  [self.titleTwoDic valueForKey:self.selectStrOne];
        if (twoArr!=nil  && twoArr.count>0) {
            [mutStr appendString:[NSString stringWithFormat:@",%@", twoArr[row2]]];
            NSInteger row3 = [self.pickerView selectedRowInComponent:2];
            NSArray *thirdArr  =  [self.titleThirdDic valueForKey:twoArr[row2]];
            if (thirdArr!=nil && thirdArr.count>0) {
                [mutStr appendString:[NSString stringWithFormat:@",%@", thirdArr[row3]]];
            }
        }
    }
    
    NSLog(@"selectStr = %@",mutStr);

    if ([self.delegate conformsToProtocol:@protocol(DYO_PickViewDelegate)]) {
        if ([self.delegate respondsToSelector:@selector(pickViewdidSelect:)]) {
            [self.delegate pickViewdidSelect:mutStr];
        }
    }
    
    [self hideSelf];
}




#pragma mark UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.list;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == component)
    {
        return self.titleOneArr.count;
    }
    
    if (1 == component) {
        NSInteger rowOne = [pickerView selectedRowInComponent:0];
        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
        if (twoArr!=nil && twoArr.count > 0) {
            return  twoArr.count;
        }
        return  0;

    }else{
        
        NSInteger rowOne = [pickerView selectedRowInComponent:0];
        NSInteger rowTwo =  [pickerView selectedRowInComponent:1];
        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
        
        if (twoArr!=nil && twoArr.count > 0) {
            NSArray *thirdArr = [self.titleThirdDic valueForKey:twoArr[rowTwo]];
            if (thirdArr!=nil && thirdArr.count > 0) {
                return thirdArr.count;
        }
            return  0;
        }
        return  0;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
     return  SCREEN_S.width/self.list;
}
// 选中某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (0 == component) {
        self.selectStrOne = self.titleOneArr[row];
        if (self.list > 1) {
            [pickerView reloadComponent:1];
            [self pickerView:pickerView didSelectRow:0 inComponent:1];
        }
    }
    
    if (1 == component) {
  if (self.list>2) {
            [pickerView reloadComponent:2];
            [self pickerView:pickerView didSelectRow:0 inComponent:2];
        }
    }
}

////返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    
//    if (0 ==  component ) {
//        return  self.titleOneArr[row];
//    }
//    
//    if (1 == component) {
//        NSInteger rowOne = [pickerView selectedRowInComponent:0];
//        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
//        if (!IsNilOrNull(twoArr)&&twoArr.count > 0) {
//            return  twoArr[row];
//        }
//    }
//    
//    if (2 == component) {
//        NSInteger rowOne = [pickerView selectedRowInComponent:0];
//        NSInteger rowTwo =  [pickerView selectedRowInComponent:1];
//        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
//        
//        if (!IsNilOrNull(twoArr) && twoArr.count > 0) {
//            NSArray *thirdArr = [self.titleThirdDic valueForKey:twoArr[rowTwo]];
//            if (!IsNilOrNull(thirdArr) && thirdArr.count > 0) {
//                return thirdArr[row];
//            }
//        }
//    }
//    return  @"";
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    // 获得标题
    NSString *title = @"";
    if (0 == component ) {
        title = self.titleOneArr[row];
    }
    if (1 == component) {
        NSInteger rowOne = [pickerView selectedRowInComponent:0];
        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
        if (twoArr!=nil&&twoArr.count > 0) {
            title = twoArr[row];
        }
    }
    if (2 == component) {
        NSInteger rowOne = [pickerView selectedRowInComponent:0];
        NSInteger rowTwo =  [pickerView selectedRowInComponent:1];
        NSArray *twoArr =  [self.titleTwoDic valueForKey:self.titleOneArr[rowOne]];
        
        if (twoArr!=nil&& twoArr.count > 0) {
            NSArray *thirdArr = [self.titleThirdDic valueForKey:twoArr[rowTwo]];
            if (thirdArr!=nil&& thirdArr.count > 0) {
                title = thirdArr[row];
            }
        }
    }
    
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        // 无可复用view, 创建一个新的view
        CGSize size = [pickerView rowSizeForComponent:component];
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        label = [[UILabel alloc] initWithFrame:frame];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.text = title;
    return label;
}



#pragma mark 懒加载
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_S.height - 200, SCREEN_S.width, 200)];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
- (NSArray *)titleOneArr {
    if (!_titleOneArr) {
        _titleOneArr = [NSArray new];
    }
    return _titleOneArr;
}
- (NSDictionary *)titleTwoDic {
    if (!_titleTwoDic) {
        _titleTwoDic = [NSDictionary new];
    }
    return _titleTwoDic;
}
- (NSDictionary *)titleThirdDic {
    if (!_titleThirdDic) {
        _titleThirdDic = [NSDictionary new];
    }
    return _titleThirdDic;
}
@end
