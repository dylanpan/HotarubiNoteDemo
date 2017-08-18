//
//  secondViewController.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/7/7.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "secondViewController.h"

#define SymbolURL @"http://img2.ali213.net/picfile/News/2016/08/19/584_2016081912516593.png"
#define ZeusURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022204242.png"
#define CrystalMaidenURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022204121.jpg"
#define DrowRangerURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022205916.jpg"
#define FacelessVoidURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022205678.jpg"
#define KeeperOfTheLightURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022205304.jpg"
#define KunkkaURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022206305.jpg"
#define NightStalkerURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022206256.jpg"
#define RikiURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022206755.jpg"
#define SpiritBreakerURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022207551.jpg"
#define TemplarAssassinURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022207309.jpg"
#define TideHunterURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022207145.jpg"
#define WindRunnerURL @"http://images.enet.com.cn/egames/articleimage/2013/0826/20130826022208143.jpg"
#define QueenOfPainURL @"http://img.bizhi.sogou.com/images/2013/11/29/425176.jpg"
#define MyHTTPSChessURL @"https://cdn.pixabay.com/photo/2015/12/13/10/00/chess-1090862_960_720.jpg"
#define MyHTTP404URL @"http://www.shusp.com/wp-content/uploads/2015/11/shadow-from-the-dire-dota-2-wallpaper-1024x576.jpg"

@interface secondViewController ()

@property (strong, nonatomic) maskAnimator *maskAnimator;
@property (strong, nonatomic) maskLayerViewController *myMaskLayerViewController;

@end

@implementation secondViewController

@synthesize myPhotoURLArray = _myPhotoURLArray;
@synthesize myPhotoNameArray = _myPhotoNameArray;

- (void) setMyPhotoURLArray:(NSArray *)myPhotoURLArray{
    _myPhotoURLArray = myPhotoURLArray;
}

- (NSArray *)myPhotoURLArray{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:ZeusURL,CrystalMaidenURL,DrowRangerURL,FacelessVoidURL,KeeperOfTheLightURL,KunkkaURL,NightStalkerURL,RikiURL,SpiritBreakerURL,TemplarAssassinURL,TideHunterURL,WindRunnerURL,MyHTTPSChessURL,MyHTTP404URL,nil];
    return mutableArray;
}

- (void) setMyPhotoNameArray:(NSArray *)myPhotoNameArray{
    _myPhotoNameArray = myPhotoNameArray;
}

- (NSArray *)myPhotoNameArray{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:@"Zeus",@"Crystal Maiden",@"Drow Ranger",@"Faceless Void",@"Keeper Of The Light",@"Kunkka",@"Night Stalker",@"Riki",@"Spirit Breaker",@"Templar Assassin",@"Tide Hunter",@"Wind Runner",@"HTTPS",@"HTTP404",nil];
    return mutableArray;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.maskAnimator = [[maskAnimator alloc] init];
        NSLog(@"secondViewController.m\ninit animator successed\n");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //属性传值
    self.secondLabel.text = self.secondLabelText;
    
    //KVC传值，需要目标ViewController声明相应key对应名称的属性
    //[self.secondLabelTwo.text valueForKey:@"secondLabelTwoText"];//这个报错：提示没有定义相应的key【reason: '[<__NSCFConstantString 0x101632528> valueForUndefinedKey:]: this class is not key value coding-compliant for the key secondLabelTwoText.'】
    /*重写下列方法解决此错误，然并卵
     - (void) setValue:(id)value forUndefinedKey:(NSString *)key{
     NSLog(@"no value no key\n");
     }
     - (id) valueForUndefinedKey:(NSString *)key{
     NSLog(@"no key\n");
     return nil;
     }
     */
    self.secondLabelTwo.text = self.secondLabelTwoText;
    
    self.URLImageView = [[UIImageView alloc] init];
    self.URLImageView.frame = CGRectMake(20.0, 60.0, 370, 290);//必须设置好imageView的位置和大小，否则缩放后不能移动图片
    self.URLImageView.backgroundColor = [UIColor yellowColor];
    self.URLImageView.layer.borderWidth = 1.0;
    self.URLImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.URLImageView];
    
    UILabel *errorLabel = [[UILabel alloc] init];
    errorLabel.frame = CGRectMake((self.URLImageView.frame.origin.x)/2, (self.URLImageView.frame.origin.y)/2, self.URLImageView.frame.size.width, self.URLImageView.frame.size.height);
    errorLabel.numberOfLines = 0;
    errorLabel.textAlignment = NSTextAlignmentCenter;
    [self.URLImageView addSubview:errorLabel];
    self.errorLabel = errorLabel;
    
    self.myProgressBar.progress = 0;
    
    [self startLoadMyImage:SymbolURL];
    
    [self initCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击button，通过delegate去完成关闭view controller的工作
- (IBAction)backAsWell:(id)sender {
    if (self.secondDelegate && [self.secondDelegate respondsToSelector:@selector(dismissPresentedViewController:)]){
        [self.secondDelegate dismissPresentedViewController:self];
        NSLog(@"secondViewController.m\ncall dismiss delegate\n");
    }else{
        NSLog(@"secondViewController.m\ndidnot call dismiss delegate\n");
    }
}

- (IBAction)toX:(id)sender {
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    maskLayerViewController *destinationController = [segue destinationViewController];
    
    destinationController.transitioningDelegate = self;
    destinationController.modalPresentationStyle = UIModalPresentationCustom;
    
    //一下这行代码仅限说明，在转场中无效
    //不建议这样做，发送同步请求，同步请求在主线程中执行会一直在等待服务器返回数据，会阻塞主线程的执行，如果服务器没有返回数据，那么在主线程UI会卡住不能继续执行操作
    //UIImage *destinationControllerImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:SymbolURL]]];
    
    [destinationController setValue:self.URLImageView.image forKey:@"myImage"];
}

- (void) initCollectionView{
    //创建布局对象
    UICollectionViewFlowLayout *myCollectionViewFlowLayer = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    myCollectionViewFlowLayer.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置顶部和底部视图的大小
    myCollectionViewFlowLayer.headerReferenceSize = CGSizeMake(10, 40);
    myCollectionViewFlowLayer.footerReferenceSize = CGSizeMake(10, 40);
    //创建容器视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 380, 370, 230) collectionViewLayout:myCollectionViewFlowLayer];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //设置背景色，默认黑色
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.layer.borderWidth = 1.0;
    collectionView.layer.borderColor = [UIColor blackColor].CGColor;
    //添加视图
    [self.view addSubview:collectionView];
    self.myCollectionView = collectionView;
    
    //注册方块视图
    [collectionView registerClass:[noteCollectionViewCell class] forCellWithReuseIdentifier:[noteCollectionViewCell collectionViewCellIdentifier]];
    //注册顶部和底部视图
    [collectionView registerClass:[noteHeaderCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[noteHeaderCollectionView headerViewIdentifier]];
    [collectionView registerClass:[noteFooterCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[noteFooterCollectionView footerViewIdentifier]];
    
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//设置每一组有多少个方块
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myPhotoNameArray.count;
}

//设置方块视图
- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，若无，创建一个新的cell
    noteCollectionViewCell *cell = [noteCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    //设置cell的属性
    cell.contentView.backgroundColor = [UIColor yellowColor];
    NSString *myString = self.myPhotoNameArray[indexPath.row];
    cell.noteLabelInCell.text = [NSString stringWithFormat:@"%2ld.%@",indexPath.row+1,myString];
    
    return cell;
}

//设置顶部和底部视图
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        noteHeaderCollectionView *headerView = [noteHeaderCollectionView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor orangeColor];
        headerView.noteLabelInHeader.text = [NSString stringWithFormat:@"pick one DOTA photo"];
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        noteFooterCollectionView *footerView = [noteFooterCollectionView footerViewWithCollectionView:collectionView forIndexPath:indexPath];
        
        footerView.backgroundColor = [UIColor orangeColor];
        footerView.noteLabelInFooter.text = [NSString stringWithFormat:@"no more photo"];
        return footerView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayer
//设置各个方块的大小
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 100;
    CGFloat height = 100;
    return CGSizeMake(width, height);
}

//设置每一组的上下左右间距
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
//方块视图被选中的时候调用
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *selectURL = self.myPhotoURLArray[indexPath.row];
    [self startLoadMyImage:selectURL];
    NSString *selectURLName = self.myPhotoNameArray[indexPath.row];
    NSLog(@"secondViewController.m\nselect cell %2ld.%@\n",indexPath.row+1,selectURLName);
}

//方块视图取消选中的时候调用
- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *deselectURL = self.myPhotoNameArray[indexPath.row];
    self.URLImageView.image = nil;
    NSLog(@"secondViewController.m\ncancell select cell %2ld.%@\n",indexPath.row+1,deselectURL);
}

#pragma mark - modal transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    NSLog(@"secondViewController.m\nmodal present transition delegate\n");
    return self.maskAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSLog(@"secondViewController.m\nmodal dismiss transition delegate\n");
    return self.maskAnimator;
}

- (void) startLoadMyImage:(NSString *)laodImageURL{
    //生成请求地址
    NSURL *myImageURL = [NSURL URLWithString:laodImageURL];
    //创建请求对象
    self.myRequest = [NSURLRequest requestWithURL:myImageURL];
    //iOS9之后使用NSURLSession，session的delegate属性是只读的，想要设置代理只能通过创建session
    NSURLSessionConfiguration *myConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    myConfiguration.timeoutIntervalForRequest = 600;
    self.mySession = [NSURLSession sessionWithConfiguration:myConfiguration delegate:self delegateQueue:nil];
    //创建任务
    self.myDataTask = [self.mySession dataTaskWithRequest:self.myRequest];
    //启动任务
    [self.myDataTask resume];
    
    NSLog(@"secondViewController.m\nstart download task\n");
}

//异步方式获取图片
#pragma mark - NSURLSessionDelegate
//接收到服务器的响应
- (void) URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    NSLog(@"secondViewController.m\ndid Receive Response\n");
    
    self.myData = [[NSMutableData alloc] init];
    //保存接受到的响应对象，以便响应完毕后的状态
    self.myResponse = response;
    
    NSHTTPURLResponse *myHTTPResponse = (NSHTTPURLResponse *)self.myResponse;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.errorLabel.text = [NSString stringWithFormat:@"WAIT!!HTTP Response Status Code:%ld\n",(long)myHTTPResponse.statusCode];
        //可以在显示图片之前用本地的图片占位置
        drawPhoto *myLoadingImage = [[drawPhoto alloc] init];
        self.URLImageView.image = [myLoadingImage drawContentPhotoWithWidth:100.0 height:100.0 positionX:5.0 positionY:5.0 color:[UIColor orangeColor]];
    });
    NSLog(@"secondViewController.m\nmyHTTPResponse.statusCode = %ld\n",(long)myHTTPResponse.statusCode);
    
    //允许处理服务器的响应，才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}

//接收到服务器的数据（可能调用多次）
- (void) URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nonnull NSData *)data{
    //处理每次接收的数据
    //用于保存从网络上接收到的数据
    [self.myData appendData:data];
    //从此委托中获取到图片加载的速度
    double currentProgress = (double)self.myData.length / (double)self.myResponse.expectedContentLength;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myProgressBar.progress = currentProgress;
        self.myProgressBar.hidden = NO;
    });
    NSLog(@"secondViewController.m\ndid Receive Data\n");
    
    
    NSHTTPURLResponse *myHTTPResponse = (NSHTTPURLResponse *)self.myResponse;
    NSLog(@"secondViewController.m\nReceive Data,myHTTPResponse.statusCode = %ld\n",(long)myHTTPResponse.statusCode);
}

//请求成功或者失败（如果失败，error有值）
- (void) URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    NSLog(@"secondViewController.m\ndid finish\n");
    
    //加载成功，在此的加载成功并不代表图片加载成功，需要判断http返回状态
    NSHTTPURLResponse *myHTTPResponse = (NSHTTPURLResponse *)self.myResponse;
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.errorLabel.text = [NSString stringWithFormat:@"NO!!HTTP Response Status Code:%ld\n",(long)myHTTPResponse.statusCode];
            
            //请求异常，在此可以进行出错后的操作，如给UIImageView设置一张默认的图片
            drawPhoto *myErrorImage = [[drawPhoto alloc] init];
            self.URLImageView.image = [myErrorImage drawContentPhotoWithWidth:100.0 height:100.0 positionX:5.0 positionY:5.0 color:[UIColor redColor]];
        });
        
        NSLog(@"secondViewController.m\nerror = %@\n",error);
    }else{
        if (myHTTPResponse.statusCode == 200) {
            //请求成功
            dispatch_async(dispatch_get_main_queue(), ^{
                self.errorLabel.text = nil;
                UIImage *mySuccessImage = [UIImage imageWithData:self.myData];
                self.URLImageView.image = mySuccessImage;
            });
            
            NSLog(@"secondViewController.m\ni got my photo\n");
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.errorLabel.text = [NSString stringWithFormat:@"Ohs!!HTTP Response Status Code:%ld\n",(long)myHTTPResponse.statusCode];
                NSLog(@"secondViewController.m\nno error,but myHTTPResponse.statusCode = %ld\n",(long)myHTTPResponse.statusCode);
            });
        }
    }
}
 
/*
- (void) startLoadMyImage:(NSString *)laodImageURL{
    //生成请求地址
    NSURL *myImageURL = [NSURL URLWithString:laodImageURL];
    //创建请求对象
    self.myRequest = [NSURLRequest requestWithURL:myImageURL];
    //iOS9之后使用NSURLSession，session的delegate属性是只读的，想要设置代理只能通过创建session
    NSURLSessionConfiguration *myConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    myConfiguration.timeoutIntervalForRequest = 600;
    self.mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //创建任务
    self.myDownloadTask = [self.mySession downloadTaskWithRequest:self.myRequest];
    //启动任务
    [self.myDownloadTask resume];
    
    NSLog(@"secondViewController.m\nstart download task\n");
}

- (void) pauseLoadMyImage{
    NSLog(@"secondViewController.m\npause download task\n");
    
    if (self.myDownloadTask) {
        //取消下载任务，把已下载的数据保存起来
        [self.myDownloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.myPartialData = resumeData;
            self.myDownloadTask = nil;
        }];
    }
}

- (void) resumeLoadMyImage{
    NSLog(@"secondViewController.m\nresume download task\n");
    
    if (!self.myDownloadTask) {
        //判断是否存在已下载的数据，若有就继续断点下载，否则重新下载
        if (self.myPartialData) {
            self.myDownloadTask = [self.mySession downloadTaskWithResumeData:self.myPartialData];
        }else{
            self.myDownloadTask = [self.mySession downloadTaskWithRequest:self.myRequest];
        }
    }
    [self.myDownloadTask resume];
}

//创建文件本地保存目录
- (NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLArrays = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLArrays[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}

//把文件拷贝到指定路径
- (BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"secondViewController.m\ncopy file error = %@\n",error);
        return false;
    }
}

#pragma mark - NSURLSessionDownloadDelegate
//完成下载任务，保存文件
- (void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location{
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己拷贝至放置该文件的目录
    NSLog(@"secondViewController.m\nDownload success for URL:%@\n",location.description);
    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    BOOL success = [self copyTempFileAtURL:location toDestination:destination];
    if (success) {
        //文件保存成功后，使用GCD调用主线程把图片文件显示在UIImageView中
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *downloadImage = [UIImage imageWithContentsOfFile:[destination path]];
            self.URLImageView.image = downloadImage;
            self.URLImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.URLImageView.hidden = NO;
        });
    }else{
        NSLog(@"secondViewController.m\nmeet error when copy file\n");
    }
    self.myTask = nil;
}

- (void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //刷新进度条的delegate方法，同样的，获取数据，调用主线程刷新UI
    double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myProgressBar.progress = currentProgress;
        self.myProgressBar.hidden = NO;
    });
}

- (void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
*/








@end
