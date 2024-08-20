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
- Flask `pip install flask`

1. Download the .zip file from the relese page. 
2. Mess with the AutoIt scripts to change the x and y pos of the mouse to fit your screen size. Tip: the Autolt Window Info program shows your mouse coordinates.
3. Run the webserver with python app.py
4. Pray it runs
5. Open <HostIP>:5000 on any browser in your local network (or outside if you have a server with a public IP or a router that can port forward (also a funny way to leak your discord messages)), and tada!

# Useage

The first text box is messgage content, the seccond is the number your DM is from the top of the page (eg. your top most dm is 1, next is 2, ect...). Hit send to send your message. Refresh will update the .txt files on the server that contain your dm messages. IMPORTANT: Do not send messages while the server is refreshing, it generally screws stuff up. To veiw your DM's click on the link with the DM number you want. 

![image](https://github.com/user-attachments/assets/6785158e-7ce4-4c55-9ad1-917191991f30)


# Notes

AutoIt is a very powerfull automation tool so it would be very easy to expand this app. If you have a free afternoon any time soon, take a go at learning some AutoIt script and see what you can come up with. This entire tool so far was built in a coupple hours, so it won't take long.

Oh yeah I also tested this for like 5 minutes so give me a heads up if it dies.
