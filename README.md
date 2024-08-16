# Network Data

## Purpose

I have have been experiencing bouts of poor connectivity from my internet service provider, three.ie, so I decided to record some quantitative data by hacking together a script to record ping times to any server or other machine accessible by TCP/IP, and display the results in a Jupyter Notebook.

## Contents

1. Script to record data: `pingdata.sh`;
2. Jupyter Notebook that uses `matplotlib.pyplot` to display said data.

## Notes

At present the log file name is hard coded; TODO: graph every logfile in the `logs/` directory by looping over the directory.