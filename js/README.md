Password Close Enough
=============

This is an example implementation that provides feedback if your input password is "close enought"
to your actual password in the data store. Nobody in their right mind should use this on an actual
site as it provides too much information back to a would be hacker (they can do anything by the way).

I've implemented this for fun because I always mistype my passwords and wish sometimes the site
I am entering would just let me in if the password is close enough.

Implementation Concept
-------
The implementation concept is simple. When I mistype my passwords, the pressed key is usually close
in proximity to another character on the keyboard. So the implementation has a simple english board
for characters and digits. 

Example
-------
Say your password has an "S" in it and you mistype that position character in the password. The 
following would be valid mistypes: Q,W,E,A,D,Z,X,C. Or, the characters around the central point.

If you had an "Q" then valid mistypes would be: W,S,A. 

Pretty simple. 

Requirements
-------
* jQuery - becuase of easy of dom selection and events
* Hatred for security 

Running
-------
Just pull down the code and run the demo by executing an HTTP server. I use: python -m SimpleHTTPServer

