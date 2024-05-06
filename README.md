# GalleryApp (Swift using Native technology)

1  MVVM Architecture pattern Design with Observer design pattern 
2  First load from memory NSCache used after that will used cached memory and then will get from server 
3.   


Task:

Develop an application for iOS to efficiently load and display images in a scrollable grid.
Not used any third-party image loading library.

Tasks:

Image Grid: Show a 3-column square image grid. The images should be center-cropped. ------>  Done

Image Loading: ------>  Done

Implement asynchronous image loading using this url. ------>  Done



imageURL = domain + "/" + basePath + "/10/" + key  ------>  Done

Display: User should be able to scroll through at least 100 images. ------>  Done

Caching:  Develop a caching mechanism to store images retrieved from the API in both memory and disk cache for efficient retrieval. ------>  Done

Error Handling: Handle network errors and image loading failures gracefully when fetching images from the API, providing informative error messages or placeholders for failed image loads. ------>  Done

Implementation to be done in Swift using Native technology. ------>  Done

Evaluation criteria

Images should load lazily. Also if you are on for example page 1 and quickly scroll to page 10, then then the image loading of page 1 should be cancelled, and it should start loading for page 10. ------>  Done

There must be absolutely no lag while scrolling the image grid. ------>  Done

Disk and Memory cache both should work. Disk cache should be used If image is missing in memory cache. When image is read from disk, memory cache should be updated.  ------>  Done

If your code does not compile with the latest Xcode, your assignment will be rejected without checking. ------>  Done

Step by step and clear instructions should be present in the README file to run the code if any.


Mode of submission

Push it on GitHub and share the link with us.




