#Readme
-----------
Important files:

	lib/log_parser.rb
	app/controllers/requests_controller.rb
	logit_client/src/client.js
	logit_client/src/requests.js

General Rundown:
This is a small app for reviewing rails logs. In order to get it running simply create the database and migrate:

	rake db:create && rake db:migrate

and then run the parser rake task to load the data into the database:

	rake logs:parse

Once this is done simply access the server at localhost:3000 (where the react app is served from the Rails public directory) and the logs should populate.

At the top are a couple of quick buttons for finding log statements with warnings, and for sorting the logs by the slowest to render.

Below this is a search bar that searches the full body of the log statement (across multiple lines). This is where most of the interesting information can be gleaned. For instance searching 'POST' will give you all of the POSTs, searching for 'paperclip' will give you all the logs of requests that uploaded/deleted files via paperclip, and searching for a particular controller or action will yield log statements relating to it.

The (albeit minor) templating was done via Bulma, which I haven't used before and acts a little funny at different resolutions.
