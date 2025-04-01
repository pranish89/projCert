#image from Github provided by edureka, 
FROM devopsedu/webapp

#Copy the website to the image 
Copy website/ /var/www/html

#Expose port no
Expose 80

#Command to run for container
CMD ["apachectl", "-D", "FOREGROUND"]
