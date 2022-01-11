## Installation

To download this script and its dependencies, copy and paste the following commands into your bash terminal.

```bash
# Install Dependencies
sudo apt update
sudo apt install imagemagick ruby-full wget



# Download Script
sudo wget https://github.com/Valkryst/Automated_Responsive_Image_Resizing/blob/main/convert.rb
```

With the script downloaded, you must then perform these steps:

* Move the script into its own folder.
 
  * e.g. `/home/conversion/image`

* Edit the script and make the following changes:
 
  * Change `/home/conversion/image` in the statement  `Dir.chdir('/home/conversion/image')` to point to the folder in which you placed the script.

* Run the script with `ruby convert.rb` to generate all necessary subfolders.

* Add a [cron](https://en.wikipedia.org/wiki/Cron) job to run the script at a set interval.
 
  * e.g. `0 * * * * ruby /home/conversion/image/convert.rb > /home/conversion/image/convert.log`

## Usage

Place files and folders in the `todo` folder and they will be converted by the cron job.

## Important Notes

* Images are resized to a width of `1920`, `1366`, `854`, and `320`. If the source image is smaller than one of these widths, then no output image is created for that width. Aspect ratios are maintained.

* Only files ending in `.bmp`, `.jpg`, `.jpeg`, `.png`, and `.raw` are processed.

* Original files are preserved, but moved to the `complete` folder after their alternatively-sized copies are created.
