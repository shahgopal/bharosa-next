<template>
	<div>
		<h1>LOGIN OK?</h1>
		<p><a href="#" m-on:click="logInWithFacebook">Log In Facebook</a></p>
	</div>
</template>

<script>
	var store = require('../store.js');
	var util = require('../util.js');
	var axios = require('axios');

	(function(d, s, id){
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {return;}
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	exports = {
		hooks: {
			mounted: function() {
				if(store.authenticated === true) {
					util.redirect("");
				}
			}
		},
		methods: {
			logInWithFacebook: function() {
				var self = this;

				FB.init({
      				appId: '277670635984811',
    				cookie: true,
      				version: 'v2.2'
    			});
    
    			FB.login(function(response) {
      				if(response.authResponse !== null) {
      					var fbToken = response.authResponse.accessToken;
      					axios.post('http://localhost:9000/auth/facebook', {
      						access_token: fbToken
      					}).then(function(response) {
      						var data = response.data;
      						store.accessToken = data.token;
      						store.user = data.user;
      						store.authenticated = true;
      					})
      				}
    			});
  			}
		}
	}
</script>
