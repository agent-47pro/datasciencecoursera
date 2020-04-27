How does the script work?

1. The file is stored in the file name. 

2. The file is downloaded, check whether the folder exists and put in a folder. 

3. Create data frames for the files in the UCI HAR dataset folder. These are text files which should be converted to data frames. 

4. This part merges the training and the test sets to create one data set. 

5. This parts extracts only the measurements on mean and standard deviation for each measurement. 

6. Activity names are renamed to make them descriptive and easily understandable to a layman.

7.  Another tidy data set is created which has the average of each variable for each activity and each subject. This file is stored in the .txt format.