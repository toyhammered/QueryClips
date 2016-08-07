var vizEditor = ace.edit("viz-editor");

vizEditor.getSession().setMode("ace/mode/javascript");
vizEditor.getSession().setTabSize(2);
vizEditor.setOptions({
  minLines: 10,
  maxLines: Infinity,
  showPrintMargin: false
});

var textArea = $('textarea[name="code"]').hide();
vizEditor.getSession().on('change', function() {
  textArea.val(vizEditor.getSession().getValue());
});

var jsonData = JSON.parse($("#json-data").html());
var transformedData = {};
var jsonLabels = Object.keys(jsonData[0]);

for (i = 0; i < jsonLabels.length; i++) {
  var label = jsonLabels[i];
  var data = jsonData.map(function(hash) { return hash[label]; });
  transformedData[label] = data;
}

$("#json-data-transformed").html(JSON.stringify(transformedData));
var runViz = function() {
  var jscode = vizEditor.getValue();
  eval(jscode);
  var highChartsConfig = generateHighCharts(jsonData, transformedData);
  $("#viz").highcharts(highChartsConfig);
}

runViz();
