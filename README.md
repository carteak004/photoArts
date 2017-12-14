# photoArts
iOS mobile app that will allow users to purchase photo arts, pay for the purchase by credit card and receive sales order receipt via
email as a confirmation.


The app will read an image-list file and download each of the small image files named there. The app will display the thumbnail images using a collection view with two columns.

When a user touches a thumbnail image, the app will take the user to a different view which shows a larger image and let's user choose the frame, size and quantity needed. The prize is also shown accordingly. User can add the item to the cart or go back to the collection view.

All the items added to the cart will be shown in a table view along with the frame, size and quantity selected and a subtotal for each item. User can edit the quantity or delete the item from the cart in the cart view itself. When the user is ready to check out, user can click on checkout button in the checkout screen. This will show an action sheet which asks the user to either Sign in or Check out as Guest. 

If chose to Sign in, user will be taken to a Sign in page where user can enter username and password or can create an account. User can also change the password in case he/she forgot the password. Signing in whii retain the purchase history of the user and will be shown once logged in. After successfull Sign in/Sign up, user will be taken to check out screen. If chose to check out as guest, user will be taken to check out screen.

In the check out screen, user can select the type of shipping and the expected delivery rate and total price to be charged will be updated accordingly. Once done, user will be asked to enter shipping information and then billing information. All the fields are mandatory in every screen and will be validated once the user moves to next field. If there is any field left blank or not entered correctly, user will not be able to proceed to the next screen.

Once everything is entered, user can review the order one last time. The review screen shows the thumbnails of all the items checked out in a horizantally scrollable collection view. The scren also shows the estimated date of delivery, shipping and billing information and the Total to be charged on the card. User can edit any information from this screen or can go back to cart. When the user clicks on Place order button, an alert is displayed to confirm if the order is to be placed. Once confirmed, an e-mail view will be presented which contains the details of the order in the body. User has to click send to get the confirmation on e-mail and then will be redirected to Home Screen. User will be automatically logged out if signed in. 


_This project is done for a course requirement of NIU_
