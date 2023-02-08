
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:

// use testServerConnectionCurl.txt
// set vs code 'Change language mode' to 'HTTP' 
// by accessing command palette (ctrl + shift + p)

Parse.Cloud.define("hello", (request) => {
	return "Hello RalphyBoy!";
  });
