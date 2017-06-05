<template>
  <div>
    <h1>{{campaign.name}}</h1>
    <h3>{{campaign.reason}}</h3>
    <h5><img m-if="campaign.createdBy.picture" src="{{campaign.createdBy.picture}}"/> {{campaign.createdBy.name}}</h5>
    <p>{{campaign.details}}</p>
    <button m-on:click="showPay">Pay</button>
    <modal m-if="paying" padding="75px">
      <h4 class="text-center">Pay</h4>
      <p class="text-center">Donate {{amount}} ₹ to {{campaign.createdBy.name}} for their <em>{{campaign.name}}</em> campaign, and help them with {{campaign.reason}}.</p>
      <label class="text-left">Name
        <input type="text" value="{{name}}" disabled m-if="authenticated">
        <input type="text" m-model="name" placeholder="What is your name?" m-if="!authenticated">
      </label>
      <label class="text-left">Amount
        <input type="number" placeholder="How much would you like to donate?" m-model="amount">
      </label>
      <button m-on:click="pay" m-if="amount > 0" class="button">Donate</button>
    </modal>
  </div>
</template>
<style scoped>
  h4 {
    font-family: "Raleway", sans-serif;
  }

  img {
    border-radius: 50%;
  }
</style>
<script>
  var store = require('../store.js');
  var util = require('../util.js');

  exports = {
    props: ['route'],
    data: function() {
      return {
        campaign: {
          name: '-',
          details: '-',
          createdBy: {
            name: '-',
            picture: null
          }
        },
        paying: false,
        authenticated: store.authenticated,
        name: "Anonymous",
        amount: 100
      }
    },
    methods: {
      showPay: function() {
        if(this.get("authenticated") === true) {
          this.set("name", store.user.name);
        }
        this.set('paying', true);
      },
      pay: function() {
        var name = this.get("name");
        if(this.get("authenticated") === true) {
          name = store.user.id;
        }
        store.pay(name, this.get('route').params.id, this.get('amount'));
      }
    },
    hooks: {
      mounted: function() {
        var self = this;
        var mounted = function() {
          var routeID = self.get('route').params.id;
          var campaign = store.campaigns.filter(function(item) {
          if(item.id === routeID) {
            return item;
          }
          })[0];
          self.set('campaign', campaign);
        }

        if(store.campaigns.length === 0) {
          store.fetchCampaigns(function(campaigns) {
            store.campaigns = campaigns;
            mounted();
          });
        } else {
          mounted();
        }
      }
    }
  }
</script>
