module.exports.get = function(key) {
	return localStorage.getItem(key);
}

module.exports.save = function(key, item) {
	localStorage.setItem(key, item);
}

module.exports.extend = function(obj1, obj2) {
	for(var key in obj2) {
		obj1[key] = obj2[key];
	}
}

module.exports.stringify = function(obj, exclude) {
	var newObj = {};

	if(exclude === undefined) {
		exclude = [];
	}

	for(var key in obj) {
		var value = obj[key];
		if(typeof value !== 'function' && exclude.indexOf(key) === -1) {
			newObj[key] = value;
		}
	}

	return JSON.stringify(newObj);
}

module.exports.redirect = function(url) {
	window.location.hash = '/' + url;
}