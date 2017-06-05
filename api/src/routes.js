// Payment Utilities
const payment = {
	checksum: require('../paytm/checksum.js'),
	config: require('../paytm/config.js')
}

// Model
const model = require('./model.js');

// Middlware
const middleware = require("./middleware.js");

module.exports = (app) => {
	// Authenticate API Requests Middleware
	app.use(middleware.auth);

	app.get('/api/campaigns', middleware.urlencodedParser, (req, res) => {
		model.fetchCampaigns((err, campaigns) => {
			if(err) {
				res.status(500).end('500 Internal Server Error');
			} else {
				res.type('json').send(campaigns);
			}
		})
	});


	app.post('/api/create', middleware.urlencodedParser, (req, res) => {
		const data = req.body;
		// model.saveCampaign(data);
		res.type('json').send(data);
	});

}