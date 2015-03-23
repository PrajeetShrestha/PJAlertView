# PJAlertView
This library is to make your own custom alert views to match your apps look and feel. Totally customizable.


## How to use?
Import ``` PJAlertView.h , PJAlertView.m and PJAlertView.xib``` files to your project.

 ```
 PJAlertView *alert = [[PJAlertView alloc]initWithTitle:@"Error!" message:@"There was some error in network!!! " delegate:self cancelButtonTitle:nil okButtonTitle:nil];
[alert show]; 

```

As simple as that . Now you can modify the colors and other properties of PJAlertView.xib file to customize alert view according to your app.
    
####Note that you should not alter the layout constraints of the PJAlertView.xib and outlets. Just modify color and shadow properties.

*For any queries please feel free to mail me at prajeet.shrestha@gmail.com*
    
