module.exports = function(Moon) {
	Moon.component("modal", {
		functional: true,
		props: ['padding'],
		render: function(h, ctx) {
			var padding = ctx.data.padding; return h("div", {attrs: {"class": "modal card", "style": "padding: " + padding + ""}}, {"shouldRender": true}, [h("div", {attrs: {"class": "card-section"}}, {"shouldRender": true}, [].concat.apply([], [ctx.slots['default']]))]);
		}
	});
}