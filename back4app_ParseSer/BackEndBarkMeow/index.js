// Example express application adding the parse-server module to expose Parse
// compatible API routes.

const express = require('express');
const ParseServer = require('parse-server').ParseServer;
const path = require('path');
const args = process.argv || [];
const test = args.some(arg => arg.includes('jasmine'));

const databaseUri = process.env.DATABASE_URI;//reading from environment variables. environment variables listed in app.yaml file.

if (!databaseUri)
{
  //if the database is not mentioned in the environment variables, databaseUri will be 'not defined'.
  console.log('DATABASE_URI not specified, falling back to localhost.');
}

const config =
{
  databaseURI: databaseUri || 'mongodb://127.0.0.1:27017/test',//if the databaseUri is 'not defined' then local database will be used.
  cloud: process.env.CLOUD_CODE_MAIN || __dirname + '/cloud/main.js',
  appId: process.env.APP_ID || 'APPLICATION_ID',//use environment variable if available. otherwise use hardcoded value.
  masterKey: process.env.MASTER_KEY || 'MASTER_KEY', //use master key from environment variables. if it 'not defined' use hardcoded value. Keep this secret!
  serverURL: process.env.SERVER_URL || 'http://127.0.0.1:1337/parse', // Don't forget to change to https if needed.
  liveQuery: {
    classNames: ['Posts', 'Comments'], // List of classes to support for query subscriptions
  },
};
// Client-keys like the javascript key or the .NET key are not necessary with parse-server
// If you wish you require them, you can set them as options in the initialization above:
// javascriptKey, restAPIKey, dotNetKey, clientKey

const app = express();

// Serve static assets from the /public folder
app.use('/public', express.static(path.join(__dirname, '/public')));

// Serve the Parse API on the /parse URL prefix
const mountPath = process.env.PARSE_MOUNT || '/parse';
if (!test)
{
  const api = new ParseServer(config);
  app.use(mountPath, api);
}

// The Parse class expects the Parse Server URL to be in the following format:
// https://your-parse-server-url.com/parse      e.g. http://127.0.0.1:1337/parse

// Where your-parse-server-url.com( e.g. http://127.0.0.1:1337 ) is the URL of your
// Parse Server, and /parse is the mount path for your Parse API. If you have a
//different mount path, you should replace /parse with the correct path.

// We can create end-points for our parse server like /test, /health etc. as follows:
// When you access the /health endpoint locally, you should see a JSON response with
// information about the server's status

// Parse Server plays nicely with the rest of your web routes
app.get('/', function (req, res)
{
  res.status(200).send('Parse server is running.');
});

// There will be a test page available on the /test path of your server url
// Remove this before launching app
app.get('/test', function (req, res)
{
  res.sendFile(path.join(__dirname, '/public/test.html'));
});

// Parse Server provides a status endpoint that you can use to check the server's health.
// The endpoint is /health, and it returns a JSON object with information about the server's status.
// There will be a server health check available on the /health path of your server url
// remove this before launching app.
app.get('/health', function(req, res) {
  res.json({ status: 'ok' });
});

const port = process.env.PORT || 1337;
if (!test)
{
  const httpServer = require('http').createServer(app);
  httpServer.listen(port, function () {
    console.log('parse-server running on port ' + port + '.');
  });
  // This will enable the Live Query real-time server
  ParseServer.createLiveQueryServer(httpServer);

  /////////// This will load our Parse server dashboard (REMOVE THIS BEFORE PRODUCT UPLOAD TO THE SERVER) ///////////////////
  const http = require('http');
  const checkForServerObject = function isServerObject(obj)//isServerObject() method will check whether the passed value is a server object.
  {
    return obj instanceof http.Server;//if so then return true.
  }

  if (checkForServerObject(httpServer))//check if the created httpServer object is a server object.
  {
    const { exec } = require('child_process');

    const cmd = 'parse-dashboard --config parse-dashboard-config.json';//load parse server dashboard from a command.

    exec(cmd, (error, stdout, stderr) =>
    {
      if (error)
      {
        console.error(`exec error: ${error}`);//if error occurred, show an error.
        return;
      }

      console.log(`stdout: ${stdout}`);
      console.error(`stderr: ${stderr}`);
    });
  }
  else
  {
    console.error('httpServer is not a server object');//if the created httpServer object is not a server object, show an error.
  }
  /////////// This will load our Parse server dashboard (REMOVE THIS BEFORE PRODUCT UPLOAD TO THE SERVER) ///////////////////
}

module.exports =
{
  app,
  config,
};
