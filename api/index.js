// Express Config
const express = require('express');
const app = express();

// Initialize Routes
require('./src/routes')(app);

// Listen
app.listen(9000);