const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/bharosa');

const campaignSchema = mongoose.Schema({
	name: String,
	goal: String,
	reason: String,
	details: String,
	image: String,
	video: String
});

const Campaign = mongoose.model('Campaign', campaignSchema);

module.exports = {
	saveCampaign: function(data) {
		const newCampaign = new Campaign(data);
		newCampaign.save((err, item) => {});
	},
	fetchCampaigns: function(cb) {
		Campaign.find().sort('-date').limit(10).exec(cb);
	}
}