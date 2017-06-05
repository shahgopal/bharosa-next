// Configuration
const config = require('./config.js');

// Body Parser Middleware
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });

// Secure API Middleware For Client
const auth = (req, res, next) => {  
	res.header('Access-Control-Allow-Origin', 'http://localhost:8081');
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
	res.header('Access-Control-Allow-Headers', 'OPTIONS, Origin, X-Requested-With, Content-Type, Accept, X-API-Key');

	if (req.method === "OPTIONS") {
		return res.status(200).end();
  }

	const clientKey = req.headers['x-api-key'];

	if(clientKey === config.apiKey) {
		next();
	} else {
		res.status(401).end("401 Not Authorized");
	}
}

module.exports = {
	urlencodedParser: urlencodedParser,
	auth: auth
}