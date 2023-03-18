### Deploy Static Website on AWS

S3 bucket endpoint - http://my-049354170629-bucket.s3-website.us-east-2.amazonaws.com/

Cloudfront endpoint - https://d3qjver1n26hur.cloudfront.net/

In this project, you will deploy a static website to AWS using S3, CloudFront, and IAM.

The files included are: 

index.html - The Index document for the website.
/img - The background image file for the website.
/vendor - Bootssrap CSS framework, Font, and JavaScript libraries needed for the website to function.
/css - CSS files for the website.


## When I created an S3 bucket

I created a new S3 bucket and made it public
![s3](/img/Udacity-Snap1.jpg)

## Addition of Files

I uploaded the necessary files for this project to the S3 bucket
![upload](/img/Udacity-Snap2.jpg)

## Enabling Static Website Hosting

I enabled static website by going to the properties section of the S3 bucket
![hosting](/img/Udacity-Snap3.jpg)

## Inclusion of IAM bucket policy for Protection

I included an IAM bucket policy to secure the S3 bucket
![secure](/img/Udacity-Snap4.jpg)

## CloudFront Distribution

I used cloudfront to serve my website to a larger audience and also edge-location caching
![cloudfront](/img/Udacity-Snap5.jpg)