<template>
	<div class="container">
		<div class="row">
			<div class="small-12 columns text-center">
				<h1 class="header light" m-if="authenticated">Create a Campaign.</h1>
			</div>
		</div>
		<div class="form" m-if="authenticated">
			<div class="row firstGroup" m-if="group === 1">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>NAME
						<input type="text" placeholder="Something catchy..." id="name-input" m-model="name">
					</label>
				</div>
			</div>

			<div class="row firstGroup" m-if="group === 1">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>GOAL
						<input type="text" placeholder="How much do you want to make?" id="goal-input" m-model="goal">
					</label>
				</div>
			</div>

			<div class="row firstGroup" m-if="group === 1">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>REASON
						<select id="reason-input" m-model="reason">
							<option value="illness">Illness</option>
							<option value="familysupport">Family Support</option>
							<option value="education">Education</option>
							<option value="hardship">Hardship</option>
						</select>
					</label>
				</div>
			</div>

			<div class="row firstGroup" m-if="group === 1">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>DETAILS
						<textarea type="text" placeholder="In-depth details about your campaign." id="details-input" m-model="details"></textarea>
					</label>
				</div>
			</div>

			<div class="row firstGroup" m-if="group === 1">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns text-center">
					<button class="button" id="continue-btn" m-on:click="continue">CONTINUE</button>
				</div>
			</div>

			<div class="row secondGroup" m-if="group === 2">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>PREVIEW IMAGE
						<input type="file" placeholder="Set an image that represents your campaign." id="preview-img-input" m-model="image">
					</label>
					<img id="preview-img" class="hidden"/>
				</div>
			</div>

			<div class="row secondGroup" m-if="group === 2">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns">
					<label>VIDEO
						<input type="url" placeholder="Link to a Youtube video." id="video-input" m-model="video"/>
					</label>
				</div>
			</div>

			<div class="row secondGroup" m-if="group === 2">
				<div class="small-6 small-offset-3 medium-4 medium-offset-4 columns text-center">
					<button class="button outline" id="back-btn" m-on:click="back">BACK</button>
					<input type="submit" class="button" id="submit-btn" value="SUBMIT" m-on:click="submit"/>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
	.container {
		margin-top: 40px;
	}
</style>

<script>
	var axios = require('axios');
	var store = require('../store.js');
	var util = require('../util.js');

	exports = {
		data: function() {
			return {
				group: 1,
				authenticated: store.authenticated,
				name: '',
				goal: '',
				reason: 'illness',
				details: '',
				image: '',
				video: ''
			}
		},
		methods: {
			continue: function() {
				this.set('group', 2);
			},
			back: function() {
				this.set('group', 1);
			},
			submit: function() {
				axios.post('http://localhost:9000/campaigns', {
					access_token: store.accessToken,
					name: this.get('name'),
					goal: this.get('goal'),
					reason: this.get('reason'),
					details: this.get('details'),
					image: this.get('image'),
					video: this.get('video')
				}).then(function(response) {
					var campaign = response.data;
					store.campaigns.push(campaign);
					util.redirect("campaign/" + campaign.id);
				});
			}
		},
		hooks: {
			init: function() {
				this.set('authenticated', store.authenticated);
			},
			mounted: function() {
				if(!this.get('authenticated')) {
					util.redirect('login');
				}
			}
		}
	}
</script>