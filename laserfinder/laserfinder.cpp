#include <ctime>
#include <unistd.h>
#include <iostream>
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/highgui/highgui.hpp"

using namespace std;

int main ( int argc,char **argv ) {

  time_t timer_begin, timer_end;
  cv::Mat laserOn, laserOff,
    laserOnGray, laserOffGray,
    diff, thresh, out;

  if(argc < 2){
    cerr << "Usage: " << argv[0] << " <image, lasers off> <image, lasers on>"
      << endl;
    return -1;
  }

  laserOff = cv::imread(argv[1]);
  laserOn = cv::imread(argv[2]);

  cv::cvtColor(laserOff, laserOffGray, CV_RGB2GRAY);
  cv::cvtColor(laserOn, laserOnGray, CV_RGB2GRAY);

  // Take the difference of the two images and threshold it
  cv::absdiff(laserOffGray,laserOnGray,diff);
  cv::threshold(diff, thresh, 64, 255,0);

  // Save these too
  cv::imwrite("diff.jpg",diff);
  cv::imwrite("thresh.jpg",thresh);

  //Search for blobs
  // First, set up the parameters
  cv::SimpleBlobDetector::Params params;
  params.minDistBetweenBlobs = 50.0f;
  params.filterByInertia = false;
  params.filterByConvexity = false;
  params.filterByColor = false;
  params.filterByCircularity = false;
  params.filterByArea = true;
  params.minArea = 20.0f;
  params.maxArea = 500.0f;

  // Search for the blobs
  cv::Ptr<cv::FeatureDetector> blob_detector = new cv::SimpleBlobDetector(params);
  blob_detector->create("SimpleBlob");
  vector<cv::KeyPoint> keypoints;
  blob_detector->detect(thresh, keypoints);

  // Convert the "off" image to color so we can draw red circles on it
  cvtColor(laserOff, out, CV_GRAY2RGB);
  cout << keypoints.size() << " points located." << endl;

  // Draw a red circle for each blob we've found
  for (int i=0; i<keypoints.size(); i++){
      float x=keypoints[i].pt.x;
      float y=keypoints[i].pt.y;
      cv::circle(out, keypoints[i].pt, 3, cv::Scalar(0,0,255), -1);
  }

  // Save the locations
  cv::imwrite("location.jpg",out);

  cout<<"Complete."<<endl;
  //*/
}
