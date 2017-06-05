<template>
  <div>
    <h2 m-if="campaigns.length > 0">Latest Campaigns</h2>
    <ul>
      <li m-for="campaign in campaigns"><router-link to="/campaign/{{campaign.id}}">{{campaign.name}}</router-link></li>
    </ul>
  </div>
</template>
<style scoped>
  
</style>
<script>
  var store = require('../store.js');
  var util = require('../util.js');

  window.addEventListener('beforeunload', function() {
    util.save('bharosa__store', util.stringify(store, ["campaigns", "fetchCampaigns", "pay"]))
  });

  exports = {
    data: function() {
      return {
        campaigns: []
      }
    },
    hooks: {
      mounted: function() {
        var self = this;
        var mounted = function() {
          self.set('campaigns', store.campaigns);
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
