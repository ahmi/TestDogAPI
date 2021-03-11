# Test Dog API 

Following App is an exercise to consume APIs from [open source dog pictures](https://dog.ceo/dog-api/).

## Installation

Checkout ```master``` branch, (or download the project 
) run ```pod install``` to install 1 dependency 

Open ```.workspace``` That's it


## Specs and Topic Covered
App is developed using Xcode 12.0 and deployment target is 14.0

App consumes [All breeds API](https://dog.ceo/api/breeds/list/all) to show all breeds of dogs in collectionView

 App loads breed list and [fetches random images from separate endpoint](https://dog.ceo/api/breeds/image/random) loads from URL to show in every cell. 

On tap, that specific cell updates its image from [random image endpoint]((https://dog.ceo/api/breeds/image/random) )

App uses one 3rd party library to show [Progress HUD](https://github.com/JonasGessner/JGProgressHUD)

App follows MVVM architecture with separate Network layer 

Network layer is a reusable component with Generic datasource and custom Error mapper




## Limitations

There are certain limitations due to API response datastructure i-e 

1 - [All breeds](https://dog.ceo/api/breeds/list/all) list only returns breed names but requirement was to show breed image as well. To fetch separate image for each ```collectionView``` cell, no parameters documentation is provided as in documentation [breed images can be retrieved by selecting breed from dropdown](https://dog.ceo/dog-api/breeds-list). (Part of solution was to use breed name as parameter to fetch breed image but apparently breed names shown in drop down and breed name used as parameter were different. it can be seen in early commits)

2 - Since there is no image of breed in list breed end point, random images are being fetched. These images are being downloaded in background, once completed cell image is updated. Every time cell is dequeued image is fetched again


## To Do (Extended requirement)
- Unit Tests
- UI Tests

## License
[MIT](https://choosealicense.com/licenses/mit/)
