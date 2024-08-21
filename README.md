# KoboDiscord
Discord for Kobo ereaders (with browser) or any device with a basic web browser really.

A small webserver that reads and writes discord messages using Python Flask and AutoIt. 

# Limitations

- Only supports as many DM's as can be displayed on your servers screen at one time. Should be easy to change though. Mine is 8 so thats what the poject is configured to right now. 
- Servers are not supported, should be easy to add.
- Only display the amount of message that can fit on your screen at one time. Again, should not be too hard to make that better.
- No images
- Slow refresh time

# Setup and Install

Prequisits
- AutoIt: https://www.autoitscript.com/site/autoit/downloads/
- Flask: `pip install flask`
- Notepad: download folder set to the recived_messages folder

1. Download the .zip file from the relese page. 
2. Mess with the AutoIt scripts to change the x and y pos of the mouse to fit your screen size. Tip: the Autolt Window Info program shows your mouse coordinates.
3. Run the webserver with python app.py
4. Pray it runs
5. Open <HostIP>:5000 on any browser in your local network (please add some security if you want to make it accessible from the intenet), and tada!

# Useage

Click on the DM you want, they are listed in the order they apear on discord. Type message, send message, obsesivily hit refresh until you get a reply (IMPORTANT: Wait until it refreshes before pressing the button again, or messaging). 

Warning: if you text a DM that is not 1, that DM automaticaly becomes DM1, as it does on discord. It will not automatically change you to DM1, thats a feature for another day, so make sure you switch to DM1 before messaging again, otherwise you'll be messaging the wrong person.

A full refresh refreshes all your DMs messages, not just the current one. This happens if there are no reccords in the recived_messages folder. Caution, it takes awhile and you cannot do anything else during that time otherwise sh!t starts breaking in all kinds of beutifull ways I could never envision.

![image](https://github.com/user-attachments/assets/b61c740b-fab8-444e-bf34-31b2905025d7)

# Notes

AutoIt is a very powerfull automation tool so it would be very easy to expand this app. If you have a free afternoon any time soon, please go down the rabbit hole. It saves me a lot of time.

Oh yeah I also tested this for like 5 minutes so give me a heads up if it dies.
