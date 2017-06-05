<template>
	<div class="card">
		<div class="card-section">
			<img src="{{account.picture}}"/>
    		<h4>{{account.name}}</h4>
		</div>
	</div>
</template>
<style scoped>
.card {
	margin-top: 150px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	width: 300px;
	border: none;
	box-shadow: 10px 10px 50px rgba(0, 0, 0, 0.1);
	transition: box-shadow 0.3s ease;
}

.card:hover {
	box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.15);
}

.card img {
	margin-bottom: 1rem;
	border-radius: 50%;
}
</style>
<script>
	var store = require('../store.js');
	var util = require('../util.js');
	exports = {
		data: function() {
			return {
				account: {
					name: '-',
					picture: ''
				}
			}
		},
		hooks: {
			mounted: function() {
				if(!store.authenticated) {
					util.redirect("login");
				} else {
					this.set('account', store.user);
				}
			}
		}
	}
</script>