/*=============================
  Primary Application Code
=============================*/

var Moon = require("moonjs/dist/moon.js");
var MoonRouter = require("moon-router");
var home = require("./components/home.moon")(Moon);
var campaign = require("./components/campaign.moon")(Moon);
var create = require("./components/create.moon")(Moon);
var login = require("./components/login.moon")(Moon);
var account = require("./components/account.moon")(Moon);
var notFound = require("./components/notFound.moon")(Moon);
var modal = require("./components/modal.js")(Moon);

Moon.use(MoonRouter);

var router = new MoonRouter({
	'default': '/NotFound',
	'map': {
		'/': 'home',
		'/NotFound': 'notFound',
		'/account': 'account',
		'/create': 'create',
		'/login': 'login',
		'/campaign/:id': 'campaign'
	}
})

var app = new Moon({
  el: "#app",
  router: router
});
