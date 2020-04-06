#import "ViewController.h"

#define HEIGHT 35
#define LEFT_LABEL 20
#define TOP_VALUE 60
#define LEFT_TEXTFIELD 120
#define WIDTH UIScreen.mainScreen.bounds.size.width


@interface ViewController ()

@property (weak, nonatomic) UIButton *buttonProcess;
@property (weak, nonatomic) UITextField *textFieldRed;
@property (weak, nonatomic) UITextField *textFieldGreen;
@property (weak, nonatomic) UITextField *textFieldBlue;
@property (weak, nonatomic) UILabel *labelRed;
@property (weak, nonatomic) UILabel *labelGreen;
@property (weak, nonatomic) UILabel *labelBlue;
@property (weak, nonatomic) UILabel *labelResultColor;
@property (weak, nonatomic) UIView *viewResultColor;

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabels];
    [self setupResultView];
    [self setupTextFields];
    [self setupButton];

    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

- (void)setupLabels {
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_LABEL, TOP_VALUE, 100, 40)];
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_LABEL, TOP_VALUE * 2, 70, HEIGHT)];
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_LABEL, TOP_VALUE * 3, 70, HEIGHT)];
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_LABEL, TOP_VALUE * 4, 70, HEIGHT)];

    [self.labelResultColor setText:@"Color"];
    [self.labelRed setText:@"RED"];
    [self.labelGreen setText:@"GREEN"];
    [self.labelBlue setText:@"BLUE"];

    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
}

- (void)setupResultView {
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(LEFT_TEXTFIELD + 20, TOP_VALUE, 250, 40)];
    [self.viewResultColor setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.viewResultColor];
}

- (void)setupTextFields {
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(LEFT_TEXTFIELD, TOP_VALUE * 2, 270, HEIGHT)];
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(LEFT_TEXTFIELD, TOP_VALUE * 3, 270, HEIGHT)];
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(LEFT_TEXTFIELD, TOP_VALUE * 4, 270, HEIGHT)];

    [self.textFieldRed setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textFieldGreen setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textFieldBlue setBorderStyle:UITextBorderStyleRoundedRect];

    [self.textFieldRed setPlaceholder:@"0..255"];
    [self.textFieldGreen setPlaceholder:@"0..255"];
    [self.textFieldBlue setPlaceholder:@"0..255"];
    
    [self.textFieldRed addTarget:self action:@selector(tapField) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldGreen addTarget:self action:@selector(tapField) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldBlue addTarget:self action:@selector(tapField) forControlEvents:UIControlEventAllTouchEvents];

    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
}

- (void)setupButton {
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2 - 50), 350, 100, 60)];

    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [self.buttonProcess addTarget:self action:@selector(pressProcess) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.buttonProcess];
}

- (void)pressProcess {
    if ([self.textFieldBlue.text length] && [self.textFieldRed.text length] &&
        [self.textFieldGreen.text length] && [self checkInputValues]) {

        int red = [self.textFieldRed.text intValue];
        int green = [self.textFieldGreen.text intValue];
        int blue = [self.textFieldBlue.text intValue];

        if (red >= 0 && red <= 255 && green >= 0 && green <= 255 && blue >= 0 && blue <= 255) {
            UIColor *color = [UIColor colorWithRed:[self.textFieldRed.text doubleValue] / 255
                                             green:[self.textFieldGreen.text doubleValue] / 255
                                             blue: [self.textFieldBlue.text doubleValue] / 255
                                             alpha:1.0];
            NSString *hexStringFromColor = [[NSString alloc] initWithFormat:@"0x%02X%02X%02X", red, green, blue];

            [self.viewResultColor setBackgroundColor:color];
            [self.labelResultColor setText:hexStringFromColor];
        } else {
            [self.labelResultColor setText:@"Error"];
            [self.viewResultColor setBackgroundColor:[UIColor grayColor]];
        }

    } else {
        [self.labelResultColor setText:@"Error"];
        [self.viewResultColor setBackgroundColor:[UIColor grayColor]];
    }

    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
}

- (BOOL)checkInputValues {
    NSCharacterSet *digitSet = [NSCharacterSet decimalDigitCharacterSet];

    NSCharacterSet *redSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldRed.text];
    NSCharacterSet *greenSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldGreen.text];
    NSCharacterSet *blueSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldBlue.text];

    if ([digitSet isSupersetOfSet:redSet] && [digitSet isSupersetOfSet:greenSet]
        && [digitSet isSupersetOfSet:blueSet]) return YES;
     else return NO;

}

- (void)tapField {
    if (![self.labelResultColor.text isEqualToString:@"Color"]) {
        self.labelResultColor.text = @"Color";
        self.viewResultColor.backgroundColor = [UIColor grayColor];
   }
}

@end
