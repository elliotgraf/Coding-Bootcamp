// from data.js
var tbody = d3.select("tbody");

//Console.log the data from data.js
console.log(data);

//Use Arrow Functions to update each cell's text with data
data.map((ufoData) => {
    var row = tbody.append("tr");
    Object.entries(ufoData).map(([key, value]) => {
        var cell = tbody.append("td");
        cell.text(value);
    });
});
// Select the submit button
var submit = d3.select("#filter-btn");

submit.on("click", function() {

 // Prevent the page from refreshing
d3.event.preventDefault();

  // Select the input element and get the raw HTML node
var inputElement = d3.select("#datetime");

    // Get the value property of the input element
var inputValue = inputElement.property("value");

console.log("User input date",inputValue);

var filteredData = data.filter(date => date.datetime === inputValue);

console.log(filteredData);

// Finally, add the summary stats to the `ul` tag
// d3.select(".summary")

});
