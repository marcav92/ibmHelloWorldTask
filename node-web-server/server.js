require('dotenv').config();
const express = require("express");
const app = express(); // create express app

// add middleware
app.use(express.static("../build"));

// start express server on port 5000
app.listen(process.env.PORT || 3000, () => {
    console.log("server started on port", process.env.PORT);
});