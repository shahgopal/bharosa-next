var axios = require('axios');
var util = require('./util.js');
var apiKey = 'b83d4b7b-7fa0-4fbd-b7bb-32501e59b672';

var store = {
	campaigns: [],
	fetchCampaigns: function(cb) {
		axios.get('http://localhost:9000/campaigns', {
			headers: {
        'X-API-Key': apiKey
       },
		}).then(function(data) {
			cb(data.data);
		});
	},
	pay: function(name, id, amount) {
		var user = this.user;
		var accessToken = this.accessToken;
		var apiData = {
			TXN_AMOUNT: amount.toString(),
			CUST_ID: name,
			ORDER_ID: "aokfman" + Date.now(),
			PAYTM_MERCHANT_KEY: "bKMfNxPPf_QdZppa",
			CALLBACK_URL: "http://localhost:9000/paytmstatus"
		}

		if(this.authenticated === true) {
			apiData['access_token'] = accessToken;
		}

		console.log(apiData)

			// access_token: this.accessToken,
			// ORDER_ID: "gopfaeasdfal123",
			// CUST_ID: ,
			// // INDUSTRY_TYPE_ID: "Retail",
			// // CHANNEL_ID: "WEB",
			// TXN_AMOUNT: amount,
			// // MID: "DIY12386817555501617",
			// // WEBSITE: "DIYtestingweb",
			// // CALLBACK_URL: "http://localhost:8080/response",
			// // PAYTM_MERCHANT_KEY: "bKMfNxPPf_QdZppa"


		axios.post('http://localhost:9000/paytmrequests', apiData).then(function(response) {
			var responseData = response.data;
			var data = responseData.data;
			var PAYTM_FINAL_URL = responseData.PAYTM_FINAL_URL;
			var form = document.createElement("form");
			form.method = "POST";
			form.action = PAYTM_FINAL_URL;
			form.style.display = "none";
			for(var key in data) {
				var input = document.createElement("input");
				input.type = "hidden";
				input.name = key;
				input.value = data[key];
				form.appendChild(input);
			}
			document.body.appendChild(form);
			form.submit();
		});
	},
	authenticated: false,
	accessToken: null,
	user: null
}

var oldStore = util.get('bharosa__store');
if(oldStore) {
	util.extend(store, JSON.parse(oldStore));
}

module.exports = store;
